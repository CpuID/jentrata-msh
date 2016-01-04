#!/bin/bash

# Handle setting up a user/pass for Corvus access
if [ -z "$CORVUS_USER" ]; then
	echo "Error - CORVUS_USER environment variable is empty or undefined. Set this before proceeding."
	exit 1
fi

if [ -z "$CORVUS_PASS" ]; then
	echo "Error - CORVUS_PASS environment variable is empty or undefined. Set this before proceeding."
	exit 1
fi
# Remove trailing tag first
sudo sed -i "s/\<\/tomcat-users\>//" /etc/tomcat8/tomcat-users.xml
# Add new role/user/pass tags
sudo sh -c 'echo "<role rolename=\"admin\"/>" >> /etc/tomcat8/tomcat-users.xml'
sudo sh -c 'echo "<role rolename=\"corvus\"/>" >> /etc/tomcat8/tomcat-users.xml'
sudo sh -c 'echo "<user username=\"${CORVUS_USER}\" password=\"${CORVUS_PASS}\" roles=\"tomcat,admin,corvus\"/>" >> /etc/tomcat8/tomcat-users.xml'
sudo sh -c 'echo "</tomcat-users>" >> /etc/tomcat8/tomcat-users.xml'

# Handle setting up our JDBC connectivity
if [ -z "$JDBC_DRIVER" ]; then
  echo "Error - JDBC_DRIVER environment variable is empty or undefined. Set this before proceeding, example: 'com.mysql.jdbc.Driver'."
  exit 1
fi
if [ -z "$JDBC_URL" ]; then
  echo "Error - JDBC_URL environment variable is empty or undefined. Set this before proceeding, example: 'jdbc:mysql://127.0.0.1:3306/ebms'."
  exit 1
fi
# Replace tags accordingly
# TODO
ebms_module_xml_file="${JENTRATA_HOME}/plugins/hk.hku.cecid.ebms/conf/hk/hku/cecid/ebms/spa/conf/ebms.module.xml"
# <component id="daofactory" name="System DAO Factory">
# <parameter name="driver" value="com.mysql.jdbc.Driver"/>
# <parameter name="url" value="jdbc:mysql://127.0.0.1:3306/ebms"/>

# Start tomcat
# TODO - exit handler propagation etc
