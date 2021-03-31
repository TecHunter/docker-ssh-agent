#! /bin/sh -eu

export JENKINS_HOME=/home/jenkins
export BIN_DIR=/home/jenkins/bin

if [ -L ${BIN_DIR}/mvn ] && [ -e ${BIN_DIR}/mvn ] ; then
   echo "Maven linked"
else
   rm -f ${BIN_DIR}/mvn || echo 0
   ln -s ${JENKINS_HOME}/maven/bin/mvn ${BIN_DIR}/mvn
fi

