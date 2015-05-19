#!/bin/sh
# Replace environment variables
sed -i 's/\"pyflakes\"\,\"pyflakes\"/'\""$ADMIN_USERNAME"\"\,\""$ADMIN_PASSWORD"\"'/' /usr/src/app/master/master.cfg
sed -i 's/"example-slave"\, "pass"/"'"$SLAVE_USERNAME"'"\, "'"$SLAVE_PASSWORD"'"/' /usr/src/app/master/master.cfg
sed -i 's/Pyflakes/'"$PROJECT_TITLE"'/' /usr/src/app/master/master.cfg
sed -i 's,https://launchpad.net/pyflakes,'"$PROJECT_URL"',g' /usr/src/app/master/master.cfg
sed -i 's,git://github.com/junaidali/pyflakes.git,'"$GIT_REPO_URL"',g' /usr/src/app/master/master.cfg

# Start SSH-Agent
echo "Starting ssh agent"
eval `ssh-agent`

# Add all SSH keys within .ssh/. Make sure they don't have a password.
for key in `find .ssh/ -type f`
do
	if [ -f $key ]; then
		if [ ${key: -4} == ".pub" ]; then
			echo "Ignoring public key $key"
		else
			echo "Adding private key $key to ssh-agent"
			ssh-add $key
		fi
	fi
done
# Run build-master
twistd --nodaemon --no_save -y /usr/src/app/master/buildbot.tac
