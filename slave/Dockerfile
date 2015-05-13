FROM python:2-onbuild
MAINTAINER Junaid Ali <junaid@dockerhub.com>

ADD ./run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]
