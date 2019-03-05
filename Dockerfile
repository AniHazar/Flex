#FROM openjdk:8-jdk-alpine
FROM openjdk:8-jdk-alpine
MAINTAINER ranjit.jha@in.ibm.com
ADD seat-map-service-0.0.1-SNAPSHOT.jar seat-map.jar
COPY newrelic /home/newrelic/
ENTRYPOINT ["java","-javaagent:/home/newrelic/newrelic.jar","-Dnewrelic.config.app_name=cts-context","-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=ppe","-jar","/seat-map.jar"]
ARG APP_NAME
