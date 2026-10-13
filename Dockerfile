# một stage: vừa build vừa chạy
FROM eclipse-temurin:21-jdk
WORKDIR /app

COPY .gradle/ .gradle
COPY ./gradlew build.gradle ./
RUN ./gradlew dependencies --no-daemon
COPY src ./src
RUN ./gradlew clean build -x test --no-daemon
EXPOSE 8085

ENTRYPOINT ["java","-jar","libs/session-09-task-apis-v2-0.0.1-SNAPSHOT.jar"]

