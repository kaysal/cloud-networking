#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
magenta=`tput setaf 5`
bold=$(tput bold)
reset=`tput sgr0`

export TF_WARN_OUTPUT_ERRORS=1

terraform_apply() {
  RESOURCES=(
  1-vpc
  2-vpn
  #3-compute
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
