FROM openjdk:17 AS builder


WORKDIR /app
COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
COPY src/main ./src/main
RUN ./gradlew clean bootJar

FROM openjdk:17

WORKDIR /app
COPY  --from=builder /build/libs/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar" ,"app.jar"]