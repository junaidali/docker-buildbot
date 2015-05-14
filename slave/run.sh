#!/bin/bash
# Replace environment variables
sed -i 's/localhost/'"$MASTER_PORT_8010_TCP_ADDR"'/' /usr/src/app/slave/buildbot.tac
sed -i 's/example-slave/'"$MASTER_ENV_SLAVE_USERNAME"'/' /usr/src/app/slave/buildbot.tac
sed -i 's/'"passwd \= \'pass\'"'/passwd \= '\'"$MASTER_ENV__SLAVE_PASSWORD"\''/' /usr/src/app/slave/buildbot.tac

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
