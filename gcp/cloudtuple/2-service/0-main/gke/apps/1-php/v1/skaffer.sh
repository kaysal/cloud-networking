#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
white_bg=`tput setab 7`
bold=$(tput bold)
reset=`tput sgr0`

# seed: when network project is not specified

NETWORK_PROJECT='host-project-39'
REGION='europe-west1'

# select a project

export PROJECTS=$(gcloud projects list --format=json | jq -r '.[].projectId')
export AUTH_USER=$(gcloud info --format="value(config.account)")
export ACTIVE_PROJECT=$(gcloud info --format="value(config.project)")
echo -e "\nActive Project Information"
echo -e "----------------------------"
echo -e "Project\t: $ACTIVE_PROJECT"
echo -e "Account\t: $AUTH_USER"
echo -e "\nAll Projects"
echo -e "----------------------------"
choices=($PROJECTS)
PS3="Select a Project: "
select answer in "${choices[@]}"; do
  for item in "${choices[@]}"; do
    if [[ $item == $answer ]]; then
      break 2
    fi
  done
done
PROJECT=$item
echo ""
echo "--> gcloud config set project $PROJECT"
gcloud config set project $PROJECT

# select a cluster

export CLUSTERS=$(gcloud container clusters list --format=json | jq -r '.[].name')
echo ""
echo -e "\nClusters in $PROJECT"
echo -e "----------------------------"
choices=($CLUSTERS)
PS3="Select a Project: "
select answer in "${choices[@]}"; do
  for item in "${choices[@]}"; do
    if [[ $item == $answer ]]; then
      break 2
    fi
  done
done
CLUSTER=$item
echo $CLUSTER

# run skaffold cd

usage="$(basename "$0") [-h] [- n r] -- program to deploy gke services
where:
    -h help
    -n network project (host project for shared vpc)
    -r region"

while getopts h:n:r: option
do
  case "${option}" in
    h) echo "$usage"; exit;;
    n) NETWORK_PROJECT=$OPTARG;;
    r) REGION=$OPTARG;;
   \?)  printf "illegal option: -%s\n" "$OPTARG" >&2
        echo "$usage" >&2
        exit 1
        ;;
  esac
done
shift $((OPTIND - 1))
echo ""
gcloud auth configure-docker
gcloud config set compute/region ${REGION}
gcloud container clusters get-credentials ${CLUSTER} --region=${REGION}
kubectl config current-context
kubectl get nodes
echo ""
echo "----------------------------"
gcloud beta container subnets list-usable --network-project ${NETWORK_PROJECT}
echo ""
echo "----------------------------"
skaffold run --default-repo=eu.gcr.io/${PROJECT}
