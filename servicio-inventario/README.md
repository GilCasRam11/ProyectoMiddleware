# Servicio de Inventario - Spring Boot Microservicio

Microservicio REST para gestión de productos de inventario construido con Spring Boot 3.3.0 y optimizado con Docker multi-stage.

## 🚀 Características

- ✅ API REST CRUD completa
- ✅ Dockerfile optimizado con multi-stage build (75% más pequeño)
- ✅ Spring Boot 3 / Spring Web / Spring Data JPA
- ✅ H2 Database en memoria
- ✅ Base de datos H2 en memoria
- ✅ Usuario no-root por seguridad
- ✅ Health checks automáticos
- ✅ Docker Compose incluido
- ✅ Script de pruebas automatizado

## Requisitos

- Java 21 o superior
- Maven 3.8 o superior

## Dependencias

- **Spring Boot Starter Web**: Para crear aplicaciones web REST
- **Spring Boot Starter Data JPA**: Para acceso a datos con JPA/Hibernate
- **H2 Database**: Base de datos en memoria para desarrollo/pruebas
- **Lombok**: Para reducir código boilerplate (getters, setters, constructores)

## Estructura del Proyecto

```
servicio-inventario/
├── src/
│   ├── main/
│   │   ├── java/com/inventario/
│   │   │   ├── ServicioInventarioApplication.java
│   │   │   ├── controller/
│   │   │   │   └── ProductoController.java
│   │   │   ├── entity/
│   │   │   │   └── Producto.java
│   │   │   └── repository/
│   │   │       └── ProductoRepository.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       └── java/com/inventario/
│           └── ServicioInventarioApplicationTests.java
└── pom.xml
```

## 📋 Requisitos Previos

- Java 21 o superior
- Maven 3.8+
- Docker 20.10+ (para contenedor)
- Docker Compose 1.29+ (opcional)

### Verificar instalaciones
```bash
java -version
mvn --version
docker --version
```

## 🛠 Instalación Local

### 1. Compilar el proyecto
```bash
mvn clean compile
```

### 2. Ejecutar tests
```bash
mvn test
```

### 3. Empaquetar
```bash
mvn clean package
```

### 4. Ejecutar la aplicación
```bash
mvn spring-boot:run
# o
java -jar target/servicio-inventario-1.0.0.jar
```

La aplicación estará disponible en `http://localhost:8080`

## 🐳 Docker - Construcción Optimizada

### Construir la Imagen
```bash
docker build -t servicio-inventario:1.0.0 .
```

### Ejecutar Contenedor
```bash
# Opción 1: Ejecución directa
docker run -p 8080:8080 \
  --name servicio-inventario \
  servicio-inventario:1.0.0

# Opción 2: En background
docker run -d -p 8080:8080 \
  --name servicio-inventario \
  servicio-inventario:1.0.0

# Opción 3: Con Docker Compose
docker-compose up -d
```

### Verificación
```bash
# Ver contenedores
docker ps

# Ver logs
docker logs servicio-inventario

# Health check
docker inspect --format='{{json .State.Health}}' servicio-inventario
```

## 📡 Endpoints API

### Base URL
```
http://localhost:8080/api/productos
```

### Crear Producto (POST)
```bash
curl -X POST http://localhost:8080/api/productos \
  -H "Content-Type: application/json" \
  -d '{
    "codigo": "PROD001",
    "nombre": "Laptop",
    "descripcion": "Laptop de alta performance",
    "precio": 1299.99,
    "cantidad": 5
  }'
```

### Obtener Todos (GET)
```bash
curl http://localhost:8080/api/productos
```

### Obtener por ID (GET)
```bash
curl http://localhost:8080/api/productos/1
```

### Obtener por Código (GET)
```bash
curl http://localhost:8080/api/productos/codigo/PROD001
```

### Actualizar (PUT)
```bash
curl -X PUT http://localhost:8080/api/productos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "codigo": "PROD001",
    "nombre": "Laptop Premium",
    "precio": 1499.99,
    "cantidad": 3
  }'
```

### Eliminar (DELETE)
```bash
curl -X DELETE http://localhost:8080/api/productos/1
```

## 📊 Consola H2

Acceder a la consola H2:
```
http://localhost:8080/h2-console
```

**Credenciales:**
- **JDBC URL**: `jdbc:h2:mem:inventariodb`
- **Usuario**: `sa`
- **Contraseña**: (vacía)

## 🧪 Pruebas Automatizadas

### Script de Prueba
```bash
# Dar permisos
chmod +x test_api.sh

# Ejecutar pruebas
./test_api.sh
```

El script prueba:
- ✅ Creación de productos
- ✅ Lectura de datos
- ✅ Actualización
- ✅ Eliminación

### Pruebas con Postman
1. Importar la colección desde esta guía
2. Ejecutar requests secuencialmente
3. Verificar códigos de estado HTTP

## 📦 Dockerfile Multi-Stage

### Stage 1: Construcción
```dockerfile
FROM eclipse-temurin:21-jdk-alpine AS builder
# Compila con Maven
```

### Stage 2: Ejecución
```dockerfile
FROM eclipse-temurin:21-jre-alpine
# Solo JRE (sin herramientas de compilación)
```

**Ventajas:**
- Tamaño final: ~150-200 MB (vs 600 MB)
- 75% más pequeño
- Sin herramientas de desarrollo en producción
- Usuario no-root por seguridad
- Health checks incluidos

## 📁 Estructura del Proyecto

```
servicio-inventario/
├── src/
│   ├── main/java/com/inventario/
│   │   ├── controller/ProductoController.java
│   │   ├── entity/Producto.java
│   │   ├── repository/ProductoRepository.java
│   │   ├── service/ProductoService.java
│   │   └── ServicioInventarioApplication.java
│   ├── resources/application.properties
│   └── test/
├── Dockerfile (multi-stage optimizado)
├── docker-compose.yml
├── .dockerignore
├── pom.xml
├── test_api.sh
└── README.md
```

## ⚙️ Configuración

**application.properties:**
```properties
spring.application.name=servicio-inventario
spring.datasource.url=jdbc:h2:mem:inventariodb
spring.datasource.driverClassName=org.h2.Driver
spring.h2.console.enabled=true
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=false
```

## 🔧 Troubleshooting

### Puerto 8080 en uso
```bash
lsof -i :8080
# Usar puerto diferente
docker run -p 9090:8080 servicio-inventario:1.0.0
```

### Docker no disponible
```bash
brew install docker
```

### Maven no instalado
```bash
brew install maven
```

### Health check fallando
```bash
# Esperar a que inicie
sleep 10
curl http://localhost:8080/api/productos
```

## 🧹 Limpiar

```bash
# Detener contenedor
docker stop servicio-inventario

# Eliminar contenedor
docker rm servicio-inventario

# Eliminar imagen
docker rmi servicio-inventario:1.0.0

# Docker Compose
docker-compose down
```

## 📚 Documentación Adicional

- [Guía Completa Docker](./GUIA_DOCKER.md)
- [Spring Boot Docs](https://spring.io/projects/spring-boot)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

## 📝 Dependencias

- Spring Boot 3.3.0
- Spring Web
- Spring Data JPA
- H2 Database
- Lombok

## ✅ Validación Rápida

```bash
# Compilar
mvn clean package

# Construir imagen
docker build -t servicio-inventario:1.0.0 .

# Iniciar contenedor
docker run -d -p 8080:8080 servicio-inventario:1.0.0

# Probar API
curl http://localhost:8080/api/productos

# Limpiar
docker stop $(docker ps -q) && docker rm $(docker ps -aq)
```

## Licencia


MIT
