# Container image that runs your code
FROM devth/helm:v3.1.3

RUN apk add --no-cache libc6-compat

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]