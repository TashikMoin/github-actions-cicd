FROM maven:3-jdk-8
EXPOSE 8080 
# application runs on port 8080
COPY . /app
WORKDIR /app
RUN mvn clean package && \
    mvn sonar
CMD ["java","-jar","target/spring-app.jar"]




