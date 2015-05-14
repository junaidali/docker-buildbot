#!/bin/sh
# Replace environment variables
sed -i 's/localhost/'"$MASTER_PORT_8010_TCP_ADDR"'/' /usr/src/app/slave/buildbot.tac
sed -i 's/example-slave/'"$MASTER_ENV_SLAVE_USERNAME"'/' /usr/src/app/slave/buildbot.tac
sed -i 's/'"passwd \= \'pass\'"'/passwd \= '\'"$MASTER_ENV__SLAVE_PASSWORD"\''/' /usr/src/app/slave/buildbot.tac

echo $SLAVE_DESCRIPTION > /usr/src/app/slave/info/host
echo $SLAVE_ADMINISTRATOR > /usr/src/app/slave/info/admin

# Run build-slave
twistd --nodaemon --no_save -y /usr/src/app/slave/buildbot.tac
