#! /bin/sh -eu

if [ -L ${BIN_DIR}/bin/mvn ] && [ -e ${BIN_DIR}/bin/mvn ] ; then
   echo "Maven linked"
else
   rm -f ${BIN_DIR}/bin/mvn || echo 0
   ln -s ${JENKINS_HOME}/maven/bin/mvn ${BIN_DIR}/bin/mvn
fi

