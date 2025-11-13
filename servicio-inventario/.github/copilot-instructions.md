# Instrucciones de Copilot para Servicio de Inventario

## Descripción del Proyecto

Proyecto de Spring Boot 3 con Maven para gestión de inventario.

## Configuración del Proyecto

- **Tipo de Proyecto**: Spring Boot 3 REST API
- **Gestor de Dependencias**: Maven 3.9.11
- **Java Version**: 21 (OpenJDK)
- **Dependencias Principales**:
  - Spring Boot Starter Web
  - Spring Data JPA
  - H2 Database
  - Lombok
  - Spring Boot Test

## Herramientas Instaladas

✅ **Java 21** - OpenJDK Runtime Environment  
✅ **Maven 3.9.11** - Apache Maven

## Instrucciones de Compilación y Ejecución

### 1. Compilar el proyecto
```bash
mvn clean compile
```

### 2. Ejecutar tests
```bash
mvn test
```

### 3. Compilar y crear JAR ejecutable
```bash
mvn clean package
```

### 4. Ejecutar la aplicación
```bash
# Opción 1: Con Maven
mvn spring-boot:run

# Opción 2: Con el JAR generado
java -jar target/servicio-inventario-1.0.0.jar
```

## Estructura Base

- **Entidades**: `src/main/java/com/inventario/entity/`
- **Repositorios**: `src/main/java/com/inventario/repository/`
- **Controladores**: `src/main/java/com/inventario/controller/`
- **Configuración**: `src/main/resources/application.properties`

## Acceso a Servicios Locales

- **API REST**: http://localhost:8080
- **H2 Console**: http://localhost:8080/h2-console
- **H2 Credenciales**: usuario `sa`, contraseña vacía

## Estado Actual del Proyecto

✅ Proyecto creado y compilado exitosamente
✅ JAR ejecutable generado (46 MB)
✅ Tests ejecutados sin errores
✅ API CRUD funcional para productos

## Próximos Pasos

Para extender la aplicación:

1. Agregar nuevas entidades en el paquete `entity`
2. Crear repositorios correspondientes en `repository`
3. Implementar controladores REST en `controller`
4. Las migraciones de base de datos se manejan automáticamente

