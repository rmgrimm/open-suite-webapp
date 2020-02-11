FROM tomcat:8

COPY ./build/resources/main/application.properties /usr/local/tomcat/conf/application.properties
RUN sed 's|{java.io.tmpdir}/axelor|{user.home}/.axelor/axelor-erp/5.0|g' -i /usr/local//tomcat/conf/application.properties

COPY ./build/libs/axelor-erp-*.war /usr/local/tomcat/webapps/ROOT.war

RUN unzip /usr/local/tomcat/webapps/ROOT.war -d /usr/local/tomcat/webapps/ROOT
RUN rm /usr/local/tomcat/webapps/ROOT.war

ENV JAVA_OPTS="-Daxelor.config=/usr/local/tomcat/conf/application.properties"

EXPOSE 80
EXPOSE 8080

