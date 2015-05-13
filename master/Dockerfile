FROM python:2-onbuild
MAINTAINER Junaid Ali <junaid@dockerhub.com>

CMD ["buildbot", "create-master", "master"]
CMD ["cp", "master/master.cfg.sample", "master/master.cfg"]
CMD ["buildbot", "start", "master"]
EXPOSE 8010
