#!/bin/sh -l

SPRING_PROFILES_ACTIVE=build ${GITHUB_WORKSPACE}/gradlew clean check --info