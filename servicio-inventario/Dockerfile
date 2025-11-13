# Stage 1: Build
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /build

# Copiar pom.xml y descargar dependencias
COPY pom.xml .
RUN apk add --no-cache maven && \
    mvn dependency:resolve

# Copiar código fuente
COPY src ./src

# Compilar y empaquetar
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copiar JAR desde el stage de build
COPY --from=builder /build/target/servicio-inventario-1.0.0.jar app.jar

# Usuario no-root por seguridad
RUN addgroup -g 1000 appuser && \
    adduser -D -u 1000 -G appuser appuser && \
    chown -R appuser:appuser /app

USER appuser

# Exponer puerto
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# Ejecutar aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
