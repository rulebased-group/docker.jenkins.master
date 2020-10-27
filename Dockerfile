FROM jenkins/jenkins:lts

LABEL authors="Constantin Krüger"
LABEL maintainer="mail@constantin-krueger.com"

USER root
RUN apt update \
    && apt install -y --no-install-recommends \
       maven \
       python \
       python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN python -m pip install robotframework webdriver_manager
USER jenkins

RUN mkdir /var/jenkins_home/gitrepo \
    && mkdir /var/jenkins_home/jcasc

COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt



ENV JENKINS_HOME /var/jenkins_home
ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"