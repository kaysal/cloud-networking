#!/bin/bash

IFS=$'\n'
while getopts d:h: option
do
  case "${option}" in
    d) FOLDER=$OPTARG;;
    h) HELP=$OPTARG;;
esac
done

function terraform_destroy {
  cd $FOLDER
  terraform destroy -input=false
}

terraform_destroy
