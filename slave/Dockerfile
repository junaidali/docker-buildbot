FROM python:2-onbuild
MAINTAINER Junaid Ali <junaid@dockerhub.com>

ENV SLAVE_DESCRIPTION "Please put a description of this build host here"
ENV SLAVE_ADMINISTRATOR "Your Name Here <admin@youraddress.invalid>"

ADD ./run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]
