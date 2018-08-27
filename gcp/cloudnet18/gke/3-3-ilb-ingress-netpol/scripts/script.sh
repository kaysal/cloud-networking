#!/bin/bash -xe

#==================
# local linux shell
#==================

# Run terraform apply

cd
export DOCKER_IMAGE_REPO_1=ksalawu/golang-alpine:v1
export DOCKER_IMAGE_REPO_2=ksalawu/golang-alpine:v2
export DOCKER_IMAGE_REPO_3=ksalawu/golang-alpine:v3
export REGION=europe-west1
export ZONE=europe-west1-b
export SERVICE_ACCOUNT=~/tf/credentials/k8s-service-project.json
export CLUSTER=gke-33-hello-cluster
gcloud config set compute/zone ${ZONE}
gcloud config set compute/region ${REGION}

gcloud auth activate-service-account --key-file ${SERVICE_ACCOUNT}
export PROJECT_ID="$(gcloud config get-value project -q)"
gcloud container clusters get-credentials ${CLUSTER} --zone=${ZONE}
gcloud compute instances list
kubectl config current-context

git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples
cd ~/kubernetes-engine-samples/hello-app

docker login
docker build -t ${DOCKER_IMAGE_REPO_1} .
docker images

docker run --rm -p 4000:8080 ${DOCKER_IMAGE_REPO_1}
# curl http://localhost:4000

docker push ${DOCKER_IMAGE_REPO_1}

# Internal-facing app
#====================
kubectl run hello-web \
    --labels app=hello-web \
    --image=${DOCKER_IMAGE_REPO_1} \
    --port 8080 \
    --replicas=2

kubectl get pods


# Internal LB yaml deployment
#============================
cd ~/tf/gcp/cloudnet18/gke/3-3-ilb-ingress-netpol/scripts
kubectl apply -f ilb.yaml
kubectl describe service ilb-hello

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
