# Container image that runs your code
FROM mahisoft/kamino-build-images:11-jdk-alpine-docker

ENV GRADLE_USER_HOME=/build_env/gradle_config

WORKDIR /build_env

COPY gradle_config gradle_config

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]