FROM openjdk:17 AS builder
WORKDIR /app
COPY . .
RUN ./gradlew clean build -x test

# Run stage
FROM openjdk:17
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]