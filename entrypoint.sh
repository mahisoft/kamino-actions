#!/bin/sh -l

printenv

SPRING_PROFILES_ACTIVE=build ${GITHUB_WORKSPACE}/gradlew clean check --info