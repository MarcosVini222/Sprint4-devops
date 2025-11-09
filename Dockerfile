# ============================================================
# 🚀 Dockerfile para aplicação Spring Boot (Gradle)
# FIAP Sprint 4 - DevOps Tools & Cloud Computing
# ============================================================

# ====== ETAPA 1 - BUILD ======
FROM gradle:8.7.0-jdk21 AS build
WORKDIR /usr/app

COPY . .

RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

# ====== ETAPA 2 - RUNTIME ======
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copia o .jar gerado (independente do nome)
COPY --from=build /usr/app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
