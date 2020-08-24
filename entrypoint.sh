#!/bin/sh -l

export GOOGLE_APPLICATION_CREDENTIALS=/json_key.json

echo "${GCLOUD_CREDENTIALS}" > /json_key.json

helm plugin install https://github.com/nouney/helm-gcs

helm repo add social-coach-stable gs://social-coach/stable

helm repo update

/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file /json_key.json --project kamino-182816

/google-cloud-sdk/bin/gcloud container clusters get-credentials mahisoft-development --zone us-central1-a --project kamino-182816

ls -la / 

helm upgrade -i ms-account-service ./social-coach-ms-service-sql-ng-1.0.0.tgz --namespace github -f /ms-account-service/values.yaml -f /ms-account-service/dev.yaml --reset-values --set image.tag=latest