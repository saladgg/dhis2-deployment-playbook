#!/bin/sh
set -e

if [ "$(id -u)" -eq "0" ]; then
  echo "This script must NOT be run as root" 1>&2
  exit 1
fi

# Source the setenv.sh script to set environment variables
/home/{{ dhis2_app_user }}/apache_tomcat/bin/setenv.sh

# Set the CATALINA_BASE environment variable
export CATALINA_BASE="/home/{{ dhis2_app_user }}/apache_tomcat"

# Start Tomcat using the startup.sh script from the Tomcat installation directory
/usr/share/tomcat9/bin/startup.sh
echo "Tomcat started"
