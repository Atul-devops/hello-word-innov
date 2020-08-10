FROM tomcat:8
MAINTAINER Atul-project, CI-CD Docker-jenkins
COPY /webapp/target/*.war /usr/local/tomcat/webapps/
