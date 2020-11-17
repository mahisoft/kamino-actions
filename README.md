# Github Actions for Kamino

We will need several actions to perform basic tasks associated with the building, publishing and deployment of Kamino application. These should be common for backend (microservices) and frontend.

## Build

Should check if the code in the repository builds properly, passes all tests and is correctly formatted.

### Microservices

This needs to run in an image that can run docker, so that `docker-compose` can be used to start tools such as database managers and message queries.

The product of this step should be a docker container ready to be run.

### Frontend

This needs to be run in an image that contains `yarn` and `npm`.

## Publish

Should take the built container in the last step and publish it to the corresponding Nexus.

This step should also trigger *semantic release* as to assign a version to the current build.

## Deploy

Should take the built and published container and deploy it to the corresponding cloud.

This needs to be run in an image that contains `helm`.

---

# Pending
Evaluate this github action to avoid concurrence in the CI/CD process
`https://github.com/softprops/turnstyle`
