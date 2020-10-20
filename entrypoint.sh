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
./gradlew clean check --debug --init-script ./init.gradle
./gradlew bootJar --init-script ./init.gradle

# Install and run sematic-release
echo '{
        "branches": ["master"],
        "plugins":[
          "@semantic-release/commit-analyzer",
          "@semantic-release/release-notes-generator",
          ["@semantic-release/exec", { "publish" : "--no-ci -t '${version}'" }]
        ]
      }' >> .releaserc
sudo npm install -g --save-dev semantic-release
sudo npm -g install @semantic-release/git@8.0.0 @semantic-release/github @semantic-release/exec
semantic-release --branches master --repository-url ${{ github.repository }}

# Generate version tag
echo "$(git describe --tag)"
export VERSION_TAG="$(git describe --tag)"

# Generate latest tag
if [ "${GITHUB_REF:11}" = "develop" ]
then 
  export LATEST_TAG="-SNAPSHOT"
else
  export LATEST_TAG=""
fi

# Publish to nexus
# PROJECT_VERSION=$VERSION_TAG$LATEST_TAG ./gradlew publish --info --init-script ./init.gradle
echo "PROJECT_VERSION=$VERSION_TAG$LATEST_TAG"