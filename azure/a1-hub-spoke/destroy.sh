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
  #5-workload/spoke2
  #5-workload/spoke1
  #4-routes/spoke2
  #4-routes/spoke1
  #4-routes/spoke2/1-basic
  #4-routes/spoke1/1-basic
  #3-peering/hub-spoke2
  #3-peering/hub-spoke1
  #2-spokes/spoke2
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
