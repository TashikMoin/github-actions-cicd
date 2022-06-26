FROM alpine/git AS code
ARG GITHUB_SECRET 
ARG USERNAME
ARG REPOSITORY
RUN git clone https://USERNAME:${GITHUB_SECRET}@github.com/${USERNAME}/${REPOSITORY}.git /app


FROM maven:3-jdk-8 as builder
COPY --from=code /app /app 
WORKDIR /app
RUN mvn clean package && mvn sonar


FROM openjdk:8-jdk-alpine
COPY --from=builder /app/target/*.jar /artifact/spring-app.jar
EXPOSE 8080
WORKDIR /artifact
ENTRYPOINT ["java", "-jar", "spring-app.jar"]