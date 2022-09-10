FROM jenkins/jenkins:2.60.3

LABEL authors="Constantin Krüger"
LABEL maintainer="mail@constantin-krueger.com"

# Install jenknins plugins
COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

USER jenkins

ENV JENKINS_HOME=/var/jenkins_home

RUN mkdir -p $JENKINS_HOME/jcasc/ \
    && mkdir -p $JENKINS_HOME/gitrepo/
WORKDIR $JENKINS_HOME
VOLUME ["./jcasc", "./gitrepo"]

ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"