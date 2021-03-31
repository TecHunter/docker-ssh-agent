# The MIT License
#
#  Copyright (c) 2015, CloudBees, Inc.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

FROM #DOCKER_IMAGE#

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV SSHD_PORT=22
ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}
ENV BIN_DIR ${JENKINS_AGENT_HOME}/bin

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}" \
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
VOLUME "${JENKINS_AGENT_HOME}" "/tmp" "/run" "/var/run"
WORKDIR "${JENKINS_AGENT_HOME}"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
