#!/bin/bash

# Figure out where this script resides, as it might be called from an other directory (copied from catalina.sh)
# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# Switch to directory where this script resides
cd `dirname "$PRG"`

# Set JRE_HOME
if [ -d "Jre/Linux" ]; then
  # Use included JRE
  export JRE_HOME="Jre/Linux"

  # Make JRE Scripts executable (were probably stored on a FAT file system and lost rights)
  chmod u+x Jre/Linux/bin/*
else
  if [ -n "$JAVA_HOME" ]; then
    # Use local JRE
    export JRE_HOME="$JAVA_HOME"
  fi
fi

# Set Java executable
JAVA_PATH=`which java 2>/dev/null`
if [ -n "$JRE_HOME" ]; then
  RUNJAVA="$JRE_HOME"/bin/java
else
  if [ -n "$JAVA_PATH" ]; then
    # Use Java from the $PATH
    RUNJAVA="$JAVA_PATH"
  else
    echo "Could not find a Java runtime environment on you computer."
    echo "Please install version 1.6 or later of a Java runtime environment (JRE)."
    echo "If you have a JRE installed already, please set the environment variable JRE_HOME to its path."
    exit 1
  fi
fi

# Make Tomcat scripts executable (they come from a zip, so they aren't)
chmod u+x apache-tomcat-*/bin/*.sh

# Set some variables for Tomcat
export CATALINA_OPTS="-Xms128m -Xmx768m -XX:MaxPermSize=384m -Djava.util.Arrays.useLegacyMergeSort=true"

# Start HSQLDB and Tomcat
./tomcat/bin/catalina.sh run & "$RUNJAVA" -cp hsqldb/lib/hsqldb.jar org.hsqldb.Server -database.0 hsqldb/data/iteraplan -dbname.0 iteraplan > hsqldb.out

# Tell user to go browsing
echo "#####"
echo "The application has been started and should be accessible via http://localhost:8080/iteraplan"
