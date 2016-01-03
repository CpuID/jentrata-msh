FROM alpine:3.2

# http://dl-4.alpinelinux.org/alpine/edge/testing

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk -uUv add curl maven openjdk8-jre

COPY . /jentrata-msh

WORKDIR /jentrata-msh

RUN source /etc/profile && mvn clean install

# TODO: install tomcat 7.x
# TODO: untar jentrata-msh-tomcat.tar.gz

ENV JENTRATA_HOME "/dev/jentrata-msh-tomcat"
ENV TOMCAT_HOME "/dev/tomcat"
ENV JAVA_OPTS "$JAVA_OPTS -Dcorvus.home=$JENTRATA_HOME"

RUN ln -s "${JENTRATA_HOME}/webapps/corvus" "${TOMCAT_HOME}/webapps/corvus"

# TODO: add the below to $TOMCAT_HOME/conf/tomcat-users.xml
# <role rolename="admin"/>
# <role rolename="corvus"/>
# <user username="corvus" password="corvus" roles="tomcat,admin,corvus"/>

# TODO: modify JENTRATA_HOME/plugins/hk.hku.cecid.ebms/conf/hk/hku/cecid/ebms/spa/conf/ebms.module.xml with correct JDBC address.
# <component id="daofactory" name="System DAO Factory">
# <parameter name="driver" value="com.mysql.jdbc.Driver"/>
# <parameter name="url" value="jdbc:mysql://127.0.0.1:3306/ebms"/>

# TODO: start tomcat
