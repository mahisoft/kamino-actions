# Build and Publish Library

## Usage:

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
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GITHUB_REPO: ${{ github.repository }}
```