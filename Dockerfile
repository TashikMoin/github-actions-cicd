FROM alpine/git AS code
COPY . /app


FROM maven:3-jdk-8 as builder
ARG REPOSITORY
COPY --from=code /app /app 
WORKDIR /app
RUN mvn clean package


FROM openjdk:8-jdk-alpine
ARG REPOSITORY
COPY --from=builder /app/target/*.jar /app/spring-app.jar
EXPOSE 8080
WORKDIR /app
CMD ["java", "-jar", "spring-app.jar"]
