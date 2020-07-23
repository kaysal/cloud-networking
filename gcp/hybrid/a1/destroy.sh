#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
magenta=`tput setaf 5`
bold=`tput bold`
reset=`tput sgr0`

source variables.txt
export AWS_PROFILE=aws-mfa

terraform_destroy() {
  RESOURCES=(
  7-workload/spoke2
  7-workload/spoke1
  6-vpn/hub-onprem
  5-peering/hub-spoke2
  5-peering/hub-spoke1
  4-routing/spokes/spoke2
  4-routing/spokes/spoke1
  4-routing/hub
  3-onprem
  2-spokes/spoke2
  2-spokes/spoke1
  1-hub
  )

  for i in "${RESOURCES[@]}"
  do
    echo ""
    echo "${bold}${magenta}[$i]: destroying...${reset}"
    pushd $i > /dev/null
    terraform init && terraform destroy -auto-approve
    if [ $? -eq 0 ]; then
      echo "${bold}${green}[$i]: destroyed!${reset}"
      popd > /dev/null
    else
      echo "${bold}${red}[$i]: error!${reset}"
      popd > /dev/null
    fi
  done
}

time terraform_destroy
