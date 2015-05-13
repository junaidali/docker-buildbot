#!/bin/sh
# Replace environment variables
sed -i 's/localhost/'"$MASTER_PORT_8010_TCP_ADDR"'/' /usr/src/app/slave/buildbot.tac

# Run build-slave
twistd --nodaemon --no_save -y /usr/src/app/slave/buildbot.tac
