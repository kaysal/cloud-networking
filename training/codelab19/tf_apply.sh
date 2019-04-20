#!/bin/bash

IFS=$'\n'
while getopts d:h: option
do
  case "${option}" in
    d) FOLDER=$OPTARG;;
    h) HELP=$OPTARG;;
esac
done

function terraform_apply {
  cd $FOLDER
  terraform init -input=false
  terraform plan -out tfplan -input=false
  terraform apply -input=false tfplan

  if [ -f tfplan ]; then
    rm tfplan
  fi
}

terraform_apply
