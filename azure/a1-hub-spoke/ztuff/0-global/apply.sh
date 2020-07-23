#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
magenta=`tput setaf 5`
bold=`tput bold`
reset=`tput sgr0`

source variables.txt
sh ~/.azure_gcp.sh

terraform_apply() {
  RESOURCES=(
  0-global/0-rg
  0-global/1-alerts
  #0-global/2-policy
  0-global/3-ws
  )

  for i in "${RESOURCES[@]}"
  do
    echo ""
    echo "${bold}${magenta}[$i]: deploying...${reset}"
    pushd "../../$i" > /dev/null
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
