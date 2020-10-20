# Build and Publish Library

## Description

This is a GitHub action to build and publish a Kotlin lkibraty to the Nexus server in Mahisoft

## Environment variables

NEXUS_USER: The nexus server username
NEXUS_PASS: The password of the account
BRANCH_NAME: The branch where is running the action
GITHUB_REPO: The repository where the action is running


## Usage example:

```
name: CI
on:
  push:
    branches: [ develop, master ]
jobs:
  upload-library-kamino:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: git fetch --unshallow --tags
      - uses: actions/setup-java@v1
        with:
          java-version: '11'
      - name: run-library-action
        uses: mahisoft/kamino-actions@library-action
        env:
          NEXUS_USER: ${{ secrets.NEXUS_USER }}
          NEXUS_PASS: ${{ secrets.NEXUS_PASS }}
          BRANCH_NAME: ${{ github.ref }}
          GITHUB_REPO: ${{ github.repository }}
```