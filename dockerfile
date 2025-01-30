# Step 1: Use a Maven image to build the JAR
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set the working directory
WORKDIR /app

# Copy Maven project files first (to leverage Docker cache)
COPY pom.xml .
RUN mvn dependency:go-offline  # Pre-download dependencies

# Copy the rest of the application source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Step 2: Use a lightweight JRE image for runtime
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy only the built JAR from the previous step
COPY --from=build /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
