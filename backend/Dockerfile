# Dockerfile para Spring Boot backend
FROM openjdk:17-jdk-slim

ENV DB_HOST=reto2-db-service \
    DB_PORT=5432 \
    DB_USER=postgres \
    DB_PASS=adminPostgres

VOLUME /tmp

COPY target/backend-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
