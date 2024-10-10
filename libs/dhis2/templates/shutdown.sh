#!/bin/sh
export CATALINA_BASE="/home/{{ dhis2_app_user }}/apache_tomcat"
/usr/share/tomcat9/bin/shutdown.sh
echo "Tomcat stopped"
