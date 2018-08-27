#!/bin/bash -xe

#==================
# local linux shell
#==================

# Run terraform apply

cd
export DIRECTORY=~/tf/gcp/cloudtuple/4-gke/2-reg-pr-clust/scripts/cloudnet18
export HELLO_APP_DIRECTORY=~/kubernetes-engine-samples/hello-app
export PROJECT_ID=gke-service-project-54
export DOCKER_IMAGE_REPO_1=ksalawu/golang-alpine:v1
export DOCKER_IMAGE_REPO_2=ksalawu/golang-alpine:v2
export DOCKER_IMAGE_REPO_3=ksalawu/golang-alpine:v3
export DOCKER_IMAGE_REPO_4=ksalawu/golang-alpine:v4
export GCR_IMAGE_REPO_1=eu.gcr.io/${PROJECT_ID}/golang-alpine:v1
export GCR_IMAGE_REPO_2=eu.gcr.io/${PROJECT_ID}/golang-alpine:v2
export GCR_IMAGE_REPO_3=eu.gcr.io/${PROJECT_ID}/golang-alpine:v3
export GCR_IMAGE_REPO_4=eu.gcr.io/${PROJECT_ID}/golang-alpine:v4
export REGION=europe-west1
export ZONE=europe-west1-b
export SERVICE_ACCOUNT=~/tf/credentials/gke-service-project.json
export CLUSTER=reg-pr-clust
gcloud config set compute/zone ${ZONE}
gcloud config set compute/region ${REGION}
gcloud config set project ${PROJECT_ID}

gcloud auth activate-service-account --key-file ${SERVICE_ACCOUNT}
gcloud container clusters get-credentials ${CLUSTER} --region=${REGION}
gcloud compute instances list
#kubectl get nodes --output yaml | grep -A4 addresses
kubectl config current-context

# Internal-facing app - [hello-web] - ILB
#===============================================
rm -rf kubernetes-engine-samples/
git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples
cd ${HELLO_APP_DIRECTORY}
docker login
docker rmi -f $(docker images -q)
docker build -t ${DOCKER_IMAGE_REPO_1} .
docker build -t ${GCR_IMAGE_REPO_1} .
docker images

docker run --rm -p 4000:8080 ${DOCKER_IMAGE_REPO_1}
# curl http://localhost:4000

docker push ${DOCKER_IMAGE_REPO_1}
docker push ${GCR_IMAGE_REPO_1}

kubectl run hello-web \
    --labels app=hello-web \
    --image=${GCR_IMAGE_REPO_1} \
    --port 8080 \
    --replicas=2

kubectl get pods

# Internal LB yaml deployment
cd ${DIRECTORY}
kubectl apply -f ilb.yaml
kubectl describe service ilb-hello

# External-facing App - [hello-front] - NLB
#===============================================
cd ${HELLO_APP_DIRECTORY}
sed -i 's/Hello, world!/Hello from front end!/' main.go
sed -i 's/Version: 1.0.0/Version: 2.0.0/' main.go
cp main.go hellofront

docker build -t ${DOCKER_IMAGE_REPO_2} .
docker build -t ${GCR_IMAGE_REPO_2} .
docker push ${DOCKER_IMAGE_REPO_2}
docker push ${GCR_IMAGE_REPO_2}

# Deploy App
kubectl run hello-front \
    --labels app=hello-front \
    --image=${GCR_IMAGE_REPO_2} \
    --port 8080 \
    --replicas=2

# Expose App via External LB
kubectl expose deployment hello-front \
    --type=LoadBalancer \
    --port 80 \
    --target-port 8080

# External-facing App - [hello-bye] - using Ingress
#===============================================
cd ${HELLO_APP_DIRECTORY}
sed -i 's/Hello from front end!/Goodbye cruel world!/' main.go
sed -i 's/Version: 2.0.0/Version: 3.0.0/' main.go
cp main.go hellobye

docker build -t ${DOCKER_IMAGE_REPO_3} .
docker build -t ${GCR_IMAGE_REPO_3} .
docker push ${DOCKER_IMAGE_REPO_3}
docker push ${GCR_IMAGE_REPO_3}

# Deploy App
kubectl run hello-bye \
    --labels app=hello-bye \
    --image=${GCR_IMAGE_REPO_3} \
    --port 8080 \
    --replicas=2

# First, expose the app internally using nodePort
kubectl expose deployment hello-bye \
    --target-port=8080 \
    --type=NodePort

# deploy ingress yaml
cd ${DIRECTORY}
kubectl apply -f ingress.yaml
kubectl describe ingress bye-ingress

# Step 13: Change front & bye versions of hello to call the ILB
#===============================================
cd ${DIRECTORY}
cp main-extra.go ${HELLO_APP_DIRECTORY}/main.go
cd ${HELLO_APP_DIRECTORY}
sed -i 's/Hello, world!/Goodbye cruel world!/' main.go
sed -i 's/Version: 1.0.0/Version: 3.0.0/' main.go
sed -i 's/\[Put Your ILB Ingress IP Here\]/10.0.8.8/' main.go

docker build -t ${DOCKER_IMAGE_REPO_4} .
docker build -t ${GCR_IMAGE_REPO_4} .
docker push ${DOCKER_IMAGE_REPO_4}
docker push ${GCR_IMAGE_REPO_4}

kubectl set image deployment/hello-bye \
  hello-bye=${GCR_IMAGE_REPO_4}




# docker rmi -f $(docker images -q)
