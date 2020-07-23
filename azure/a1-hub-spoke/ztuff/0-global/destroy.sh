#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
magenta=`tput setaf 5`
bold=`tput bold`
reset=`tput sgr0`

source variables.txt
sh ~/.azure_self.sh

terraform_destroy() {
  RESOURCES=(
  0-global/3-ws
  0-global/2-policy
  0-global/1-alerts
  0-global/0-rg
  )

  for i in "${RESOURCES[@]}"
  do
    echo ""
    echo "${bold}${magenta}[$i]: destroying...${reset}"
    pushd "../../$i" > /dev/null
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
