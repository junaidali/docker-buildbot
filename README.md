# docker-buildbot
This is a set of Docker buildbot master and slave images. The image requires that the git repository being monitored and cloned contain two files :

+ requirements.txt : This is the python requirements file that is used to install dependencies in the build Environment
+ run_tests.sh : This is the test script used to launch tests in the build Environment

# Buildbot
Buildbot is an open-source framework for automating software build, test, and release processes. Refer to [Buildbot](http://buildbot.net/) for more details.


# How to use this image

## Building images
To build the master image

    cd master
    docker build --rm=true -q -t junaid/buildbot-master .

To build the slave image. The build slave also allows adding SSH-Keys into the container. This is achieved by adding the required SSH-Keys into the .ssh/ directory within the slave. At run time the container will add all the available keys to the SSH-Agent and use them for pulling code from the repositories (if required).

<b> NOTE: The SSH Keys should not have a passphrase. </b>

    cd slave
    # Copy any required SSH-Keys to .ssh/ directory
    mkdir .ssh/
    cp ~/.ssh/id_rsa_bitbucket .ssh/
    # Build the image
    docker build --rm=true -q -t junaid/buildbot-slave .

## Running images

### Master images

The buildbot master images are used to run the buildbot master server. This is the main server that is used to start and monitor the build activities.
To run  the buildbot master image

    docker run -d -P -p 8010:8010 --name=master junaid/buildbot-master

#### Environment Variables
The buildbot master supports the following Environment Variables

+ ADMIN_USERNAME : This is the administrator account used for logging into the web interface.
+ ADMIN_PASSWORD : This is the password for the administrator account used for logging into the web interface.
+ SLAVE_USERNAME : This is the username for the build slave.
+ SLAVE_PASSWORD : This is the password for the build slave.
+ PROJECT_TITLE : The title for the project.
+ PROJECT_URL : The URL for project details.
+ GIT_REPO_URL : The Git repository URL where the source would be pulled from and run.

The buildbot configuration is set to clone the repository, run any requirements specified in the requirements.txt file and finally run the tests in run_tests.sh script.

To start a buildmaster that uses a custom repository and project

    docker run -d -P -p 8010:8010 --name=master \
      -e GIT_REPO_URL=git@bitbucket.org:mydomain/myrepo.git \
      -e PROJECT_TITLE="My Project Title" \
      -e PROJECT_URL="https://bitbucket.org/mydomain/myproject" \
      junaid/buildbot-master

### Slave images
The slave is used to run the different builds depending upon the configuration of the build server. The slave uses linked containers to avoid exposing the buildbot RPC port (9989) over the network. It also supports running the slave connecting to a master specified by IP address/hostname.

The run the buildbot slave image linked to a master container

    docker run -d --link master:master --name=slave junaid/buildbot-slave

The run the buildbot slave without linked container, connecting to master at 192.168.10.10

    docker run -d -e MASTER_HOST=192.168.10.10 -e SLAVE_USERNAME=sample-slave -e SLAVE_PASSWORD=slavepassword --name=slave junaid/buildbot-slave

#### Environment Variables
The buildbot slave supports the following Environment Variables

+ SLAVE_DESCRIPTION : This is a small description of the slave (e.g. This is my slave).
+ SLAVE_ADMINISTRATOR : This is details of the Administrator account who monitors the slave (e.g. Joe Harris <joe.harris.company.com>)
+ MASTER_HOST : The master host information (in case not using linked container)
+ SLAVE_USERNAME : The slave's username (in case not using linked container)
+ SLAVE_PASSWORD : The slave's password (in case not using linked container)
