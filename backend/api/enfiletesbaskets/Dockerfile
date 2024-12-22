# Étape de build
FROM maven:3.8.4-openjdk-17 as build

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Étape finale pour l'exécution
FROM openjdk:21

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]