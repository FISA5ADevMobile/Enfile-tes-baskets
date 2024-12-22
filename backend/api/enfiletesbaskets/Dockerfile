# Build stage
FROM maven:3.9.8-eclipse-temurin-21 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

# Package stage
FROM openjdk:21-jdk-slim
VOLUME /tmp
COPY --from=build /home/app/target/*.jar enfiletesbaskets.jar

# Expose le port dynamiquement (Heroku le gère avec PORT)
EXPOSE 8080

# Utilise le PORT défini par Heroku
ENTRYPOINT ["java", "-jar", "/enfiletesbaskets.jar", "--server.port=${PORT}"]
