FROM alpine/git AS code
ARG SECRET 
ARG USERNAME
ARG REPOSITORY
RUN git clone https://USERNAME:${SECRET}@github.com/${USERNAME}/${REPOSITORY}.git /${REPOSITORY}


FROM maven:3-jdk-8 as builder
ARG REPOSITORY
COPY --from=code /${REPOSITORY} /${REPOSITORY} 
WORKDIR ${REPOSITORY}
RUN mvn clean package 
# mvn clean verify sonar:sonar


FROM openjdk:8-jdk-alpine
ARG REPOSITORY
COPY --from=builder /${REPOSITORY}/target/*.jar /${REPOSITORY}/spring-app.jar
EXPOSE 8080
WORKDIR /${REPOSITORY}
ENTRYPOINT ["java", "-jar", "spring-app.jar"]