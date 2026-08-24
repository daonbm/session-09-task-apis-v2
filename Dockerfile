# Stage 1: Build the application using Gradle
FROM gradle:8.5-jdk21 AS build
WORKDIR /app
COPY --chown=gradle:gradle . .
RUN ./gradlew bootJar -x test --no-daemon

# Stage 2: Run the application
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy the built jar from stage 1
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the API port
EXPOSE 8080

# Environment variables for MySQL connection (can be overridden at runtime)
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql-db:3306/taskdb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=root

ENTRYPOINT ["java", "-jar", "app.jar"]
