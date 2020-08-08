# Container image that runs your code
FROM mahisoft/kamino-build-images:11-jdk-alpine-docker

ADD init.gradle ~/.gradle/init.gradle'
ADD gradle.properties ~/.gradle/gradle.properties'

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]