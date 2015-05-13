FROM python:2-onbuild
MAINTAINER Junaid Ali <junaid@dockerhub.com>

WORKDIR /usr/src/app
ENTRYPOINT ["twistd", "--nodaemon", "--no_save", "-y", "master/buildbot.tac", "-l -"]
EXPOSE 8010 9989
