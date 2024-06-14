# Use an official Maven image to build the app
FROM maven:3.8.1-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim
WORKDIR /app
ARG JAR_FILE
COPY --from=build /app/target/${JAR_FILE} elearning.jar
ENTRYPOINT ["java", "-jar", "elearning.jar"]
