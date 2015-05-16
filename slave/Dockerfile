FROM python:2-onbuild
MAINTAINER Junaid Ali <junaid@dockerhub.com>

ENV SLAVE_DESCRIPTION "Please put a description of this build host here"
ENV SLAVE_ADMINISTRATOR "Your Name Here <admin@youraddress.invalid>"
ENV MASTER_HOST "localhost"
ENV SLAVE_USERNAME "example-slave"
ENV SLAVE_PASSWORD "pass"

# Allow Hostkeys for public hosting websites
RUN mkdir /root/.ssh
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
RUN echo "Host bitbucket.org\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

ADD ./run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]
