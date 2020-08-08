#!/bin/sh -l

echo "${NEXUS_PROPERTIES}" > /build_env/gradle_config/gradle.properties

SPRING_PROFILES_ACTIVE=build ${GITHUB_WORKSPACE}/gradlew clean check --info