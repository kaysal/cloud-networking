#!/bin/bash


# Starts Envoy and configures traffic interception on GCE VM to access
# GCP Traffic Director.
#
# Usage steps:
#   - Configure environment in "sidecar.env".
#   - Prepare Envoy binary, put it under the same directory as this script.
#   - Run this script as root: sudo /bin/bash -x </path/to/this/script>
#
# Notes:
#   - The Envoy process will be started in the background. Only one Envoy
#     process can exist at any given time; before restarting, please kill the
#     existing Envoy process.
#   - If Envoy is restarted by a different user, you might need to delete the
#     file "/dev/shm/envoy_shared_memory_0". For more info, please refer:
#     https://github.com/envoyproxy/envoy/issues/2106
#   - This script must be run as root, as required by iptables and starting
#     Envoy process using different UID.


set -o errexit
set -o nounset
set -o pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "$0 must be run with root privileges. Try sudo $0" >&2
  exit 1
fi

# Location of compulsory files.
readonly PACKAGE_DIRECTORY=$(dirname "$0")
readonly CONFIG_FILE="${PACKAGE_DIRECTORY}/sidecar.env"
readonly IPTABLES_SCRIPT="${PACKAGE_DIRECTORY}/iptables.sh"
readonly BOOTSTRAP_TEMPLATE="${PACKAGE_DIRECTORY}/bootstrap_template.yaml"
readonly BOOTSTRAP_INSTANCE="${PACKAGE_DIRECTORY}/bootstrap_instance.yaml"
readonly ENVOY_BINARY="${PACKAGE_DIRECTORY}/envoy"

function initialize() {
  # Read configuration.
  source "${CONFIG_FILE}"
  if [[ "${EXCLUDE_ENVOY_USER_FROM_INTERCEPT}" == "true" ]] && [[ -z "${ENVOY_USER}" ]]; then
    echo "ENVOY_USER must be set in $CONFIG_FILE." >&2
    exit 1
  fi

  if [[ ! -f "${ENVOY_BINARY}" ]]; then
    echo "Cannot find Envoy binary: ${ENVOY_BINARY}." >&2
    exit 1
  fi

  if [[ -z "${VPC_NETWORK_NAME}" ]]; then
    echo -n "WARNING: VPC_NETWORK_NAME is not set in the $CONFIG_FILE. " >&2
    echo "Will attempt to auto-derive, but it is recommended to set it explicitly." >&2
  fi

  if [[ -z "${GCP_PROJECT_NUMBER}" ]]; then
    echo -n "WARNING: GCP_PROJECT_NUMBER is not set in the $CONFIG_FILE. " >&2
    echo "Will attempt to auto-derive, but it is recommended to set it explicitly." >&2
  fi

  chmod +x "${IPTABLES_SCRIPT}"
  chmod +x "${ENVOY_BINARY}"
}

function enable_interception() {
  # Run iptables.sh.
  echo "Enabling traffic interception for the '${SERVICE_CIDR}' destination."
  TRAFFIC_DIRECTOR_GCE_VM_DEPLOYMENT_OVERRIDE='true'
  DISABLE_REDIRECTION_ON_LOCAL_LOOPBACK='true'
  export TRAFFIC_DIRECTOR_GCE_VM_DEPLOYMENT_OVERRIDE
  export DISABLE_REDIRECTION_ON_LOCAL_LOOPBACK
  if [[ -z "${EXCLUDE_ENVOY_USER_FROM_INTERCEPT}" ]]; then
    "${IPTABLES_SCRIPT}" \
            -i "${SERVICE_CIDR}" \
            -p "${ENVOY_PORT}" > /dev/null 2>&1
  else  # Exclude ENVOY_USER by -u option.
    envoy_user_id=$(id -u "${ENVOY_USER}")
    "${IPTABLES_SCRIPT}" \
            -i "${SERVICE_CIDR}" \
            -p "${ENVOY_PORT}" \
            -u "${envoy_user_id}" > /dev/null 2>&1
  fi
}

function disable_interception() {
  echo "Disabling traffic interception for the '${SERVICE_CIDR}' destination."
  "${IPTABLES_SCRIPT}" clean > /dev/null 2>&1
}

function get_zone() {
  # Query the GCP instance metadata server to find the zone of the current VM.
  # Delete any iptables rules created by previous executions.
  disable_interception > /dev/null
  envoy_zone=''
  query_url='http://metadata.google.internal/computeMetadata/v1/instance/zone'
  query_header='Metadata-Flavor: Google'
  query_result=$(curl "${query_url}" -H "${query_header}" -sS || true)
  if [[ -z "${query_result}" ]]; then
    echo 'Failed to get zone from GCP metadata server.' >&2
  else
    # The response is in the format: "projects/[PROJECT_NUMBER]/zones/[ZONE]"
    envoy_zone=$(echo "${query_result}" | cut -d'/' -f4 || true)
    if [[ -z "${envoy_zone}" ]]; then
      echo 'Failed to parse the result from GCP metadata server.' >&2
    fi
  fi
}


function prepare_envoy() {
  # Get Envoy GCP zone.
  get_zone
  # Generate Envoy bootstrap.
  envoy_node_id="$(uuidgen)~$(hostname -i)"
  # Set optional variables if they are not defined previously.
  if [[ -z "${TRACING_ENABLED+x}" ]]; then
    TRACING_ENABLED="false"
  fi
  if [[ -z "${ACCESSLOG_PATH+x}" ]]; then
    ACCESSLOG_PATH=""
  fi
  if [[ -z "${ENVOY_ADMIN_PORT+x}" ]]; then
    ENVOY_ADMIN_PORT="15000"
  fi
  cat "${BOOTSTRAP_TEMPLATE}" \
      | sed -e "s|ENVOY_NODE_ID|${envoy_node_id}|g" \
      | sed -e "s|ENVOY_ZONE|${envoy_zone}|g" \
      | sed -e "s|VPC_NETWORK_NAME|${VPC_NETWORK_NAME}|g" \
      | sed -e "s|CONFIG_PROJECT_NUMBER|${GCP_PROJECT_NUMBER}|g" \
      | sed -e "s|ENVOY_PORT|${ENVOY_PORT}|g" \
      | sed -e "s|ENVOY_ADMIN_PORT|${ENVOY_ADMIN_PORT}|g" \
      | sed -e "s|XDS_SERVER_CERT|${XDS_SERVER_CERT}|g" \
      | sed -e "s|TRACING_ENABLED|${TRACING_ENABLED}|g" \
      | sed -e "s|ACCESSLOG_PATH|${ACCESSLOG_PATH}|g" \
      > "${BOOTSTRAP_INSTANCE}"


  # Grant permissions to ${ENVOY_USER}.
  mkdir -p "${LOG_DIR}"
  chown "${ENVOY_USER}": "${LOG_DIR}"
  chown "${ENVOY_USER}": "${ENVOY_BINARY}"
  chown "${ENVOY_USER}": "${BOOTSTRAP_INSTANCE}"
}

function start_envoy() {
  echo "Starting Envoy process."
  su -s /bin/bash -c \
      "exec ${ENVOY_BINARY} \
              --config-path ${BOOTSTRAP_INSTANCE} \
              --log-level ${LOG_LEVEL} \
              --allow-unknown-fields \
              2> ${LOG_DIR}/envoy.err.log  \
              > ${LOG_DIR}/envoy.log \
              < /dev/null &" \
      "${ENVOY_USER}"
}

function stop_envoy() {
  echo "Stopping Envoy process."
  pkill envoy
}

function check_status() {
  ENVOY_IS_RUNNING=0
  if [[ $(pgrep -c envoy) -gt 0 ]]; then
    echo "OK: Envoy seems to be running."
    ENVOY_IS_RUNNING=1
  else
    echo "NOT ENABLED: Envoy does not seem to be running."
  fi

  if [[ $(iptables -t nat -S | grep -c ISTIO) -gt 0 ]]; then
    echo "OK: Traffic interception seems to be enabled."
  else
    echo "NOT ENABLED: Traffic interception does not seem to be enabled."
  fi
}

initialize

case ${1-usage} in
  'start')
    check_status > /dev/null
    if [[ "$ENVOY_IS_RUNNING" -eq 1 ]]; then
      echo "Envoy is already running. Will not start another one." >&2
      echo "You can stop it by running 'sudo $0 stop'." >&2
    else
      prepare_envoy
      start_envoy
    fi
    enable_interception
    check_status
    ;;
  'stop')
    disable_interception
    stop_envoy
    ;;
  'status')
    check_status
    ;;
   *)
    echo "Usage: $0 <start|stop|status>" >&2
    ;;
esac
