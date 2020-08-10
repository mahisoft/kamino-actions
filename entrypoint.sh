#!/bin/sh -l

PROPERTIES="mahiNexusUsername=${NEXUS_USER}
mahiNexusPassword=${NEXUS_PASSWORD}
sharedMavenUrl=https://nexus.mahisoft.com/repository/maven-public/
snapshotUploadUrl=https://nexus.mahisoft.com/repository/maven-snapshots/
releaseUploadUrl=https://nexus.mahisoft.com/repository/maven-releases/"

COMPOSE_OVERRIDE="
version: '3'
networks:
  default:
    external:
      name: '${GITHUB_RUN_ID}'"

echo "${PROPERTIES}" > /build_env/gradle_config/gradle.properties

echo "${COMPOSE_OVERRIDE}" > /build_env/env.network.yml

docker network create "${GITHUB_RUN_ID}"

docker-compose -f ${GITHUB_WORKSPACE}/docker-compose.yml -f /build_env/env.network.yml up -d

docker network connect ${GITHUB_RUN_ID} ${HOSTNAME}

# SPRING_PROFILES_ACTIVE=build ${GITHUB_WORKSPACE}/gradlew clean check --info

${GITHUB_WORKSPACE}/gradlew bootJar

docker build .
