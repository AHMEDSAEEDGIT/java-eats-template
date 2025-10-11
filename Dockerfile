FROM openjdk:17-jdk-slim

WORKDIR /app

COPY src/javaeats/target/javaeats.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]