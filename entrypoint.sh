#!/bin/sh -l

ls ${GITHUB_WORKSPACE}

SPRING_PROFILES_ACTIVE=build ${GITHUB_WORKSPACE}/gradlew clean check --info