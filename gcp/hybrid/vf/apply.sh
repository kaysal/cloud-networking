#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
magenta=`tput setaf 5`
bold=`tput bold`
reset=`tput sgr0`

source variables.txt
export AWS_PROFILE=aws-mfa

terraform_apply() {
  RESOURCES=(
  1-onprem
  2-spokes/spoke1
  2-spokes/spoke2
  3-vpn/spoke1-onprem
  #5-workload/spoke1
  #5-workload/spoke2
  )

  for i in "${RESOURCES[@]}"
  do
    echo ""
    echo "${bold}${magenta}[$i]: deploying...${reset}"
    pushd $i > /dev/null
    terraform fmt && terraform init && terraform apply -auto-approve
    if [ $? -eq 0 ]; then
      echo "${bold}${green}[$i]: deployed!${reset}"
      popd > /dev/null
    else
      echo "${bold}${red}[$i] error!${reset}"
      popd > /dev/null && break
    fi
  done
}

time terraform_apply
