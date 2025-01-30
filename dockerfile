# Use a base image with JDK 17 (since your project is Java 17)
FROM eclipse-temurin:17-jdk AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file into the container
COPY target/*.jar app.jar

# Expose the application's port (change if needed)
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
