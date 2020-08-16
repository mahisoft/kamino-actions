#!/bin/sh -l

PROPERTIES="mahiNexusUsername=${NEXUS_USER}
mahiNexusPassword=${NEXUS_PASSWORD}
sharedMavenUrl=https://nexus.mahisoft.com/repository/maven-public/
snapshotUploadUrl=https://nexus.mahisoft.com/repository/maven-snapshots/
releaseUploadUrl=https://nexus.mahisoft.com/repository/maven-releases/"


${GITHUB_WORKSPACE}/gradlew bootJar

docker build .
