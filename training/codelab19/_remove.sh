#!/bin/bash

export TF_WARN_OUTPUT_ERRORS=1
export GOOGLE_PROJECT=$(gcloud config get-value project)

echo "List of Labs"
echo "-----------------------"
IFS=$'\n'
export LABS=($(cat lists/labs.txt))

PS3="Select a Lab template [Press CRTL+C to exit]: "
select answer in "${LABS[@]}"; do
  for item in "${LABS[@]}"; do
    if [[ $item == $answer ]]; then
      break 2
    fi
  done
done
LAB=$item
echo -e "\nYou selected [$LAB]"
sleep 1

read -p "Are you sure you want to remove [$LAB?] (Y/N | Yes/No):"
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^([yY][eE][sS]|[yY])$ ]]
then
    exit 1
fi
echo -e "\nRemoving the base template for [$LAB]...\n"
sh tf_destroy.sh -d $LAB
