#!/bin/sh

set -e

export PATH="$HOME/bin:$PATH"

docker build -t gcr.io/${PROJECT_NAME_PRD}/${DOCKER_IMAGE_NAME}:$TRAVIS_COMMIT .

echo $GCLOUD_SERVICE_KEY_PRD | base64 --decode -i > ${HOME}/gcloud-service-key.json
gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json

gcloud --quiet config set project $PROJECT_NAME_PRD
gcloud --quiet config set container/cluster $CLUSTER_NAME_PRD
gcloud --quiet config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
gcloud --quiet container clusters get-credentials $CLUSTER_NAME_PRD

gcloud docker -- push gcr.io/${PROJECT_NAME_PRD}/${DOCKER_IMAGE_NAME}

yes | gcloud beta container images add-tag gcr.io/${PROJECT_NAME_PRD}/${DOCKER_IMAGE_NAME}:$TRAVIS_COMMIT gcr.io/${PROJECT_NAME_PRD}/${DOCKER_IMAGE_NAME}:latest

kubectl config view
kubectl config current-context

ls $HOME/bin

echo "Deploying application with kedge"
kedge apply -f ${TRAVIS_BUILD_DIR}/kedge.yaml

echo "Performing rolling update of deployment"
kubectl set image deployment/${KUBE_DEPLOYMENT_NAME} ${KUBE_DEPLOYMENT_CONTAINER_NAME}=gcr.io/${PROJECT_NAME_PRD}/${DOCKER_IMAGE_NAME}:$TRAVIS_COMMIT
