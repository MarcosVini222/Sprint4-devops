
FROM gradle:8.7.0-jdk21 AS build
WORKDIR /usr/app
COPY . .
RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /usr/app/build/libs/*.jar app.jar

EXPOSE 8080

ENV DB_USER=""
ENV DB_PASS=""
ENV GITHUB_CLIENT_ID=""
ENV GITHUB_CLIENT_SECRET=""

ENTRYPOINT ["java", "-jar", "app.jar"]
