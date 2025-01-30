# Step 1: Build the JAR inside the container
FROM eclipse-temurin:17-jdk AS build

# Set the working directory inside the container
WORKDIR /app

# Copy Maven project files (pom.xml and source code)
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Step 2: Create a smaller runtime image
FROM eclipse-temurin:17-jre

# Set working directory for the runtime container
WORKDIR /app

# Copy only the built JAR from the previous step
COPY --from=build /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
