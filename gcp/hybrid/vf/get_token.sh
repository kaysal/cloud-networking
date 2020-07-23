#!/bin/bash

# run this on laptop to generate token

SPOKE1_PROJECT=spoke1-project-s
SPOKE2_PROJECT=spoke2-project-s

gcloud config set project $SPOKE1_PROJECT
SPOKE1_TOKEN=$(gcloud auth print-access-token)
gcloud config set project $SPOKE2_PROJECT
SPOKE2_TOKEN=$(gcloud auth print-access-token)

echo "export SPOKE1_TOKEN=$SPOKE1_TOKEN"
echo "export SPOKE2_TOKEN=$SPOKE2_TOKEN"

# copy and paste token values and run the following scripts

SPOKE1_PROJECT_ID=spoke1-project-s
SPOKE2_PROJECT_ID=spoke2-project-s
COMPUTE=https://www.googleapis.com/compute/v1/projects
STORAGE=https://www.googleapis.com/storage/v1/b?project

echo "${bold}${magenta}[SPOKE 1]${reset}"
echo ""
curl --silent -X GET -H "Authorization:Bearer $SPOKE1_TOKEN" \
  $STORAGE=$SPOKE1_PROJECT_ID 2>&1

curl -X GET -H "Authorization: Bearer $SPOKE1_TOKEN" \
  https://storage.googleapis.com/${PREFIX}$SPOKE1_PROJECT_ID | xmllint --format -

echo ""
echo "${bold}${magenta}[SPOKE 2]${reset}"
echo ""
curl --silent -X GET -H "Authorization:Bearer $SPOKE2_TOKEN" \
  $STORAGE=$SPOKE2_PROJECT_ID 2>&1

curl -X GET -H "Authorization: Bearer $SPOKE2_TOKEN" \
  https://storage.googleapis.com/${PREFIX}$SPOKE2_PROJECT_ID | xmllint --format -



# Spoke 2

SPOKE1_PROJECT_ID=spoke1-project-x\r
SPOKE2_PROJECT_ID=spoke2-project-x\r
REGION=europe-west1\r
ZONE=europe-west1-b\r
SPOKE1_TOKEN=yvf9.IrABlAc49eE1IRqylI7QCW8-G9QDMpKlR3e379eqCjOPstzhdF_Np67uwXVGoCv6K0BA1FV9alNfkL89gflWnKRdwObb6Rj5f5pb-3u6XD8mX9Op3ah4NMxzv0Wncc5MarlPylPs5hmjN-8oGUSMbOBU5eD6P6p1ezt5SR7GIsKH0Xk9tfHXZT4Mg0iS6RflGYVlx7BN7ybPum-OhBIYHvFC9YooCytE7UblGqOeqKFb3CE\r
SPOKE2_TOKEN=yvf9.IrABlAdi20qeYnn5HPjIxQW5uhjhhs45KzAWzmJnfpnu5HpsngBpkhkomVZT-CP5FZPCH5q_I4DI4_ox31FehDPIbLlQ9AmSAS3aUqf4wYHn-LC8RUOWCy7ObHIGOClnzkzlROWXZnhXhy3Ktz8t8JWdwRJsKT7Vo92Er7uYhb9wfBHrObvpW6A8kITYBCpZY9u-Fc0Khq4E_WLLZQCqt_gK0chSkAM2tl_E8XycnTK_r30\r
COMPUTE=https://www.googleapis.com/compute/v1/projects\r
STORAGE=https://www.googleapis.com/storage/v1/b?project\r

curl --silent -X GET -H "Authorization:Bearer ${SPOKE2_TOKEN}" \
  ${STORAGE}=${SPOKE2_PROJECT_ID} 2>&1\r
\r\r
curl -X GET -H "Authorization: Bearer ${SPOKE2_TOKEN}" \
  https://storage.googleapis.com/lab8-${SPOKE2_PROJECT_ID} | xmllint --format - \r


#!/bin/bash
