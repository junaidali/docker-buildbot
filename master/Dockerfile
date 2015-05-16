FROM python:2-onbuild
MAINTAINER Junaid Ali <junaid@dockerhub.com>

# Environment Variables for customization
ENV ADMIN_USERNAME "pyflakes"
ENV ADMIN_PASSWORD "pyflakes"
ENV SLAVE_USERNAME "example-slave"
ENV SLAVE_PASSWORD "pass"
ENV PROJECT_TITLE "Pyflakes"
ENV PROJECT_URL "https://launchpad.net/pyflakes"
ENV GIT_REPO_URL "git://github.com/junaidali/pyflakes.git"

# Allow Hostkeys for public hosting websites
RUN mkdir /root/.ssh/
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
RUN echo "Host bitbucket.org\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

ADD ./run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]
