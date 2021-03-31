FROM #DOCKER_IMAGE#

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_HOME=/home/${user}

ENV SSHD_PORT=22
ENV JENKINS_AGENT_HOME ${JENKINS_HOME}/agent
ENV BIN_DIR ${JENKINS_HOME}/bin

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}" \
    && mkdir -p /startup && chmod 777 /startup -R \
    && mkdir -p ${BIN_DIR} && chmod 777 ${BIN_DIR} -R
ENV PATH ${BIN_DIR}:$PATH
# setup SSH server
RUN microdnf install openssh-server git\
    && microdnf clean all

RUN sed -i /etc/ssh/sshd_config \
        -e 's/#\{0,1\}PermitRootLogin.*/PermitRootLogin yes/' \
        -e 's/#\{0,1\}RSAAuthentication.*/RSAAuthentication yes/'  \
        -e 's/#\{0,1\}PasswordAuthentication.*/PasswordAuthentication no/' \
        -e 's/#\{0,1\}PubkeyAuthentication.*/PubkeyAuthentication yes/' \
        -e 's/#\{0,1\}GSSAPIAuthentication.*/GSSAPIAuthentication no/' \
        -e 's/#\{0,1\}GSSAPIKeyExchange.*/GSSAPIKeyExchange no/' \
        -e 's/#\{0,1\}SyslogFacility.*/SyslogFacility AUTH/' \
        -e 's/#\{0,1\}LogLevel.*/LogLevel INFO/' && \
    mkdir /var/run/sshd
VOLUME "${JENKINS_AGENT_HOME}"
WORKDIR "${JENKINS_AGENT_HOME}"

ARG MAVEN_VERSION=3.6.3
ARG SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p ${JENKINS_HOME}/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C ${JENKINS_HOME}/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s ${JENKINS_HOME}/maven/bin/mvn ${BIN_DIR}/mvn

ENV MAVEN_HOME ${JENKINS_HOME}/maven
ENV MAVEN_CONFIG ${JENKINS_HOME}/.m2

ADD 99maven-start.sh /startup/
ADD settings-docker.xml ${JENKINS_HOME}/maven/ref/

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
