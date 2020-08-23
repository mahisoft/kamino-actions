#!/bin/sh -l

export GOOGLE_APPLICATION_CREDENTIALS=/json_key.json

echo "${GCLOUD_CREDENTIALS}" > /json_key.json

helm plugin install https://github.com/nouney/helm-gcs

helm repo add social-coach-stable gs://social-coach/stable

helm repo update