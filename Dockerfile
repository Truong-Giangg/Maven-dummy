#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build

COPY pom.xml /usr/local/service/pom.xml
COPY src /usr/local/service/src
WORKDIR /usr/local/service
RUN mvn -f /usr/local/service/pom.xml clean package
#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /usr/local/service/target/my-app-1.0-SNAPSHOT.jar /usr/local/lib/demo.jar
EXPOSE 8089
ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]