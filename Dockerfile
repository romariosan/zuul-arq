FROM maven:3.8.1-openjdk-17-slim AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package


FROM openjdk:17-slim-buster as eureca
COPY --from=build /usr/src/app/target/*.jar /usr/app/app.jar
#ARG JAR--_FILE=/usr/src/app/target/*.jar
#COPY ${JAR_FILE} app.jar
EXPOSE 5555
ENTRYPOINT ["java","-jar","/usr/app/app.jar"]