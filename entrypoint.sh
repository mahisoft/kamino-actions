#!/bin/sh -l

echo "${GCLOUD_CREDENTIALS}" > ${GITHUB_WORKSPACE}/json_key.json

ls -la ${GITHUB_WORKSPACE}

printenv

gcloud auth activate-service-account --key-file ${GITHUB_WORKSPACE}/json_key.json --project kamino-182816

helm plugin install https://github.com/nouney/helm-gcs

helm repo add social-coach-stable gs://social-coach/stable

helm repo update