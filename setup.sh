#!/bin/bash
GITHUB_USERNAME=
GITHUB_TOKEN=
GITHUB_EMAIL=
NPM_TOKEN=
while read -p "Enter the username for your account at github.com: " GITHUB_USERNAME && [ -z "$GITHUB_USERNAME" ]; do :; done
while read -p "Enter your email registered at github.com: " GITHUB_EMAIL && [ -z "$GITHUB_EMAIL" ]; do :; done
while read -p "Enter a personal access token for your account at github.com: " GITHUB_TOKEN && [ -z "$GITHUB_TOKEN" ]; do :; done
while read -p "Enter an access token for your account at npmjs.com: " NPM_TOKEN && [ -z "$NPM_TOKEN" ]; do :; done

GITHUB_DEV_RESOURCES_REPO=circledev/developmentResources.git
GITHUB_DEV_RESOURCES_BRANCH=osc-dev-linux-desktop

echo "Starting setup... This might take a while!"

# Setup accounts
echo "--- Setting up accounts ---"
echo "machine github.com
  login $GITHUB_USERNAME
  password $GITHUB_TOKEN
  protocol https" > ~/.netrc

echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > ~/.npmrc

chmod 600 ~/.netrc
chmod 600 ~/.npmrc

git config --global user.email $GITHUB_EMAIL
git config --global user.name $GITHUB_USERNAME

echo "--- DONE ---"

# Clone developmentResources repository where all other scripts are available
echo "--- Clonning setup scripts ---"
git clone -b $GITHUB_DEV_RESOURCES_BRANCH https://$GITHUB_TOKEN@github.com/$GITHUB_DEV_RESOURCES_REPO dev_resources

# Create Directory for source code
# And copy the content to the source code folder
mkdir ./src
cp -a ./dev_resources/*.* ./src
rm -rf ./dev_resources

# switch to the source code folder
cd ./src

echo "--- DONE ---"

# Call osc setp script 
echo "--- calling osc-setup.sh ---"
bash osc-setup.sh "$GITHUB_USERNAME" "$GITHUB_TOKEN" "$GITHUB_EMAIL"
echo "--- ALL DONE ---"
