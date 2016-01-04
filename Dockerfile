FROM debian:stretch

RUN apt-get update && apt-get install -y openjdk-8-jdk maven tomcat8

COPY . /jentrata-msh

WORKDIR /jentrata-msh

RUN mvn clean install

ENV JENTRATA_HOME "/jentrata-msh/Dist/target/jentrata-msh-2.x-SNAPSHOT-tomcat"
ENV TOMCAT_HOME "/var/lib/tomcat8"
ENV JAVA_OPTS "$JAVA_OPTS -Dcorvus.home=$JENTRATA_HOME"

RUN ln -s "${JENTRATA_HOME}/webapps/corvus" "${TOMCAT_HOME}/webapps/corvus"

COPY ./docker_start_handler.sh /docker_start_handler.sh

CMD [ "/docker_start_handler.sh" ]
