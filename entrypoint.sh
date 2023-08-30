# Create configuration files
echo "initscript {
    gradle.settingsEvaluated { settings ->
        settings.pluginManagement {
            repositories {
                maven {
                    url 'https://nexus.mahisoft.com/repository/maven-public/'
                    credentials {
                        Properties properties = new Properties()
                        properties.load(new File('./gradle.properties').newDataInputStream())
                        username properties.mahiNexusUsername
                        password properties.mahiNexusPassword
                    }
                }
                gradlePluginPortal()
            }
        }
    }
}" >> init.gradle

echo "mahiNexusUsername=$NEXUS_USER
    mahiNexusPassword=$NEXUS_PASS
    sharedMavenUrl=https://nexus.mahisoft.com/repository/maven-public/
    snapshotUploadUrl=https://nexus.mahisoft.com/repository/maven-snapshots/
    releaseUploadUrl=https://nexus.mahisoft.com/repository/maven-releases/" >> gradle.properties

# Build
./gradlew clean check --info --init-script ./init.gradle
./gradlew jar --init-script ./init.gradle

# Install and run sematic-release
echo '{
        "branches": ["master", {name: "beta", prerelease: true} ],
        "plugins":[
          "@semantic-release/commit-analyzer",
          "@semantic-release/release-notes-generator",
          ["@semantic-release/exec", { "publish" : "--no-ci -t '${version}'" }]
        ]
      }' >> .releaserc
sudo npm install -g --save-dev semantic-release
sudo npm -g install @semantic-release/git@8.0.0 @semantic-release/github @semantic-release/exec
semantic-release --repository-url $GITHUB_REPO

# Generate version tag
echo "$(git describe --tag)"
VERSION_TAG="$(git describe --tag)"

# Generate latest tag and check if release
if [ $BRANCH_NAME = "refs/heads/master" ] || [ $BRANCH_NAME = "refs/heads/beta" ]
then 
  LATEST_TAG=""
  export RELEASE="true"
else
  LATEST_TAG="-SNAPSHOT"
  export RELEASE="false"
fi


# Publish to nexus
PROJECT_VERSION=$VERSION_TAG$LATEST_TAG ./gradlew publish --info --init-script ./init.gradle
