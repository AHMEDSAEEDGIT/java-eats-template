FROM openjdk:17-jdk-slim

WORKDIR /app

COPY src/javaeats/pom.xml .

RUN apt-get update && apt-get install -y maven && mvn dependency:go-offline

COPY src ./src

WORKDIR /app/src/javaeats

CMD ["mvn", "spring-boot:run"]
