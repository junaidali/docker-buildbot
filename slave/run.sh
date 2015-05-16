#!/bin/bash
# Replace environment variables with master's shared variables in case the user did not provide explicit environment variables

if [ -z "$MASTER_NAME" ]; then
	# Use user supplied environment
	sed -i 's/localhost/'"$MASTER_HOST"'/' /usr/src/app/slave/buildbot.tac
	sed -i 's/example-slave/'"$SLAVE_USERNAME"'/' /usr/src/app/slave/buildbot.tac
	sed -i 's/'"passwd \= \'pass\'"'/passwd \= '\'"$SLAVE_PASSWORD"\''/' /usr/src/app/slave/buildbot.tac
else
	# Master is defined as a linked container
	sed -i 's/localhost/'"$MASTER_PORT_8010_TCP_ADDR"'/' /usr/src/app/slave/buildbot.tac
	sed -i 's/example-slave/'"$MASTER_ENV_SLAVE_USERNAME"'/' /usr/src/app/slave/buildbot.tac
	sed -i 's/'"passwd \= \'pass\'"'/passwd \= '\'"$MASTER_ENV_SLAVE_PASSWORD"\''/' /usr/src/app/slave/buildbot.tac
fi

echo $SLAVE_DESCRIPTION > /usr/src/app/slave/info/host
echo $SLAVE_ADMINISTRATOR > /usr/src/app/slave/info/admin

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

# Run build-slave
twistd --nodaemon --no_save -y /usr/src/app/slave/buildbot.tac
