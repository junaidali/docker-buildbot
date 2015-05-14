#!/bin/sh
# Replace environment variables
sed -i 's/\"pyflakes\"\,\"pyflakes\"/'\""$ADMIN_USERNAME"\"\,\""$ADMIN_PASSWORD"\"'/' /usr/src/app/master/master.cfg
sed -i 's/\"example-slave\"\, \"pass\"/'\""$SLAVE_USERNAME"\"\, \""$SLAVE_PASSWORD"\"'/' /usr/src/app/master/master.cfg
sed -i 's/Pyflakes/'"$PROJECT_TITLE"'/' /usr/src/app/master/master.cfg
sed -i 's/https\:\/\/launchpad\.net\/pyflakes\/'"$PROJECT_URL"'/' /usr/src/app/master/master.cfg
sed -i 's/git\:\/\/github.com\/junaidali\/pyflakes.git/"$GIT_REPO_URL"'/' /usr/src/app/master/master.cfg

# Run build-master
twistd --nodaemon --no_save -y /usr/src/app/master/buildbot.tac
