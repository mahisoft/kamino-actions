#!/bin/sh -l

printenv

ls

ls ~/

SPRING_PROFILES_ACTIVE=build ${GITHUB_WORKSPACE}/gradlew clean check --info