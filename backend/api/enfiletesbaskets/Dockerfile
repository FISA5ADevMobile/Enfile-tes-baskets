# Build stage
FROM maven:3.9.8-eclipse-temurin-21 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

# Pakage stage
FROM openjdk:21-jdk-slim
VOLUME /tmp
COPY --from=build /home/app/target/*.jar enfiletesbaskets.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/enfiletesbaskets.jar"]