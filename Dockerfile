# Container image that runs your code
FROM devth/helm:v3.1.3

RUN apk add --no-cache libc6-compat

RUN echo "${GCLOUD_CREDENTIALS}" > ${GITHUB_WORKSPACE}/json_key.json

RUN gcloud auth activate-service-account --key-file ${GITHUB_WORKSPACE}/json_key.json --project kamino-182816

RUN helm plugin install https://github.com/nouney/helm-gcs

RUN helm repo add social-coach-stable gs://social-coach/stable

RUN helm repo update