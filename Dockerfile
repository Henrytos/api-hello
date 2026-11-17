FROM maven:3-openjdk-17 as builder

LABEL authors="Henry"

WORKDIR /build

COPY . .

RUN ./gradlew build -x test

FROM openjdk:17-ea-17-jdk-slim

WORKDIR /app

COPY --from=builder /build/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]