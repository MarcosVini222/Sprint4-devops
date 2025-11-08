# Etapa de build
FROM gradle:8.7.0-jdk21 AS build
WORKDIR /usr/app

COPY . .

RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

# Etapa de execução
FROM eclipse-temurin:21-jre
WORKDIR /app

# Altere o nome do JAR conforme o nome exato gerado em build/libs/
COPY --from=build /usr/app/build/libs/Sprint1-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
