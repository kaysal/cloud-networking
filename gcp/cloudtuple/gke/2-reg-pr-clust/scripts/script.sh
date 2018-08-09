#!/bin/bash -xe

#==================
# local linux shell
#==================

# Run terraform apply

cd
export PROJECT_ID=gke-service-project-ea
export DOCKER_IMAGE_REPO_1=ksalawu/golang-alpine:v1
export DOCKER_IMAGE_REPO_2=ksalawu/golang-alpine:v2
export DOCKER_IMAGE_REPO_3=ksalawu/golang-alpine:v3
export GCR_IMAGE_REPO_1=eu.gcr.io/${PROJECT_ID}/golang-alpine:v1
export GCR_IMAGE_REPO_2=eu.gcr.io/${PROJECT_ID}/golang-alpine:v2
export GCR_IMAGE_REPO_3=eu.gcr.io/${PROJECT_ID}/golang-alpine:v3
export REGION=europe-west1
export ZONE=europe-west1-b
export SERVICE_ACCOUNT=~/tf/credentials/gke-service-project.json
export CLUSTER=gke-2-reg-pr-clust
gcloud config set compute/zone ${ZONE}
gcloud config set compute/region ${REGION}
gcloud config set project ${PROJECT_ID}

gcloud auth activate-service-account --key-file ${SERVICE_ACCOUNT}
gcloud container clusters get-credentials ${CLUSTER} --region=${REGION}
gcloud compute instances list
kubectl get nodes --output yaml | grep -A4 addresses
kubectl config current-context

git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples
cd ~/kubernetes-engine-samples/hello-app
docker login
docker rmi -f $(docker images -q)
docker build -t ${DOCKER_IMAGE_REPO_1} .
docker build -t ${GCR_IMAGE_REPO_1} .
docker images

docker run --rm -p 4000:8080 ${DOCKER_IMAGE_REPO_1}
# curl http://localhost:4000

docker push ${DOCKER_IMAGE_REPO_1}
docker push ${GCR_IMAGE_REPO_1}

# Internal-facing app
#====================
kubectl run hello-web \
    --labels app=hello-web \
    --image=${DOCKER_IMAGE_REPO_1} \
    --port 8080 \
    --replicas=2

kubectl run hello-web \
    --labels app=hello-web \
    --image=${GCR_IMAGE_REPO_1} \
    --port 8080 \
    --replicas=2

kubectl run nginx \
    --labels app=hello-web \
    --image=nginx \
    --port 8080 \
    --replicas=2

kubectl get pods


# Internal LB yaml deployment
#============================
cd ~/tf/gcp/cloudtuple/gke/2-reg-pr-clust/scripts/
kubectl apply -f ilb-nginx.yaml
kubectl describe service ilb-nginx

cd ~/kubernetes-engine-samples/hello-app
cp main.go main.go.original
sed -i 's/Hello, world!/Hello from front end!/' main.go
sed -i 's/Version: 1.0.0/Version: 2.0.0/' main.go
cp main.go hellofront

docker build -t ${DOCKER_IMAGE_REPO_2} .
docker push ${DOCKER_IMAGE_REPO_2}

# External-facing App
#====================
kubectl run hello-front \
    --labels app=hello-front \
    --image=${DOCKER_IMAGE_REPO_2} \
    --port 8080 \
    --replicas=2

# External LB
#====================
kubectl expose deployment hello-front \
    --type=LoadBalancer \
    --port 80 \
    --target-port 8080

cd ~/kubernetes-engine-samples/hello-app
sed -i 's/Hello from front end!/Goodbye cruel world!/' main.go
sed -i 's/Version: 2.0.0/Version: 3.0.0/' main.go
cp main.go hellobye

docker build -t ${DOCKER_IMAGE_REPO_3} .
docker push ${DOCKER_IMAGE_REPO_3}

# External-facing App
#====================
kubectl run hello-bye \
    --labels app=hello-bye \
    --image=${DOCKER_IMAGE_REPO_3} \
    --port 8080 \
    --replicas=2

# First, expose the app internally using nodePort
#================================================
kubectl expose deployment hello-bye \
    --target-port=8080 \
    --type=NodePort

# deploy ingress yaml
#====================
cd ~/tf/gcp/cloudnet18/gke/3-3-ilb-ingress-netpol/scripts
kubectl apply -f ingress.yaml

#********************************
# Step 13: Change front & bye versions of hello to call the ILB
#********************************
cd ~/kubernetes-engine-samples/hello-app
cp hellobye main.go


# docker rmi -f $(docker images -q)
