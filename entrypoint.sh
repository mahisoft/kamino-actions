#!/bin/sh -l

PROPERTIES="mahiNexusUsername=${NEXUS_USER}
mahiNexusPassword=${NEXUS_PASSWORD}
sharedMavenUrl=https://nexus.mahisoft.com/repository/maven-public/
snapshotUploadUrl=https://nexus.mahisoft.com/repository/maven-snapshots/
releaseUploadUrl=https://nexus.mahisoft.com/repository/maven-releases/"

echo "${PROPERTIES}" > /build_env/gradle_config/gradle.properties

docker-compose -f ${GITHUB_WORKSPACE}/docker-compose.yml up -d

SPRING_PROFILES_ACTIVE=build ${GITHUB_WORKSPACE}/gradlew clean check --info