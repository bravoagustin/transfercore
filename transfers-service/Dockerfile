# syntax=docker/dockerfile:1
# Build context is the repository root (see docker-compose.yml), because the module needs the parent POM.

# ---------- Stage 1: build ----------
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /workspace

# Copy POMs first so dependency resolution is cached until a POM changes
COPY pom.xml .
COPY api-gateway/pom.xml api-gateway/
COPY contacts-service/pom.xml contacts-service/
COPY accounts-service/pom.xml accounts-service/
COPY transfers-service/pom.xml transfers-service/
COPY legacy-banking-simulator/pom.xml legacy-banking-simulator/
RUN --mount=type=cache,target=/root/.m2 mvn -B -q -pl transfers-service -am dependency:go-offline

COPY transfers-service/src transfers-service/src
# Tests run in CI and locally with Testcontainers, not inside the image build
RUN --mount=type=cache,target=/root/.m2 mvn -B -q -pl transfers-service -am package -DskipTests

# ---------- Stage 2: runtime ----------
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
RUN addgroup -S app && adduser -S app -G app
COPY --from=build /workspace/transfers-service/target/transfers-service-*.jar app.jar
USER app
EXPOSE 8083
# Respect container memory limits instead of host RAM
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75", "-jar", "/app/app.jar"]
