#!/bin/sh

CATALINA_HOME=/usr/share/tomcat9
export JAVA_HOME='/usr/lib/jvm/java-21-openjdk-amd64/'
export JAVA_OPTS='{{ dhis2_java_opts }}'
export DHIS2_HOME='/home/{{ dhis2_app_user }}/config'

# Find the Java runtime and set JAVA_HOME
. /usr/libexec/tomcat9/tomcat-locate-java.sh

# Default Java options
if [ -z "$JAVA_OPTS" ]; then
	JAVA_OPTS="-Djava.awt.headless=true"
fi
