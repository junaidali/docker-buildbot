FROM python:2-onbuild
MAINTAINER Junaid Ali <junaid@dockerhub.com>

# Environment Variables for customization
ENV ADMIN_USERNAME "administrator"
ENV ADMIN_PASSWORD "LadCypsIkGon"
ENV SLAVE_USERNAME "example-slave"
ENV SLAVE_PASSWORD "pass"
ENV PROJECT_TITLE "Pyflakes"
ENV PROJECT_URL "https://launchpad.net/pyflakes"
ENV GIT_REPO_URL "git://github.com/junaidali/pyflakes.git"

ADD ./run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]
