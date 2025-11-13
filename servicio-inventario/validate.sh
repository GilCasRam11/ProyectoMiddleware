#!/bin/bash

# Script de validación rápida del proyecto
# Uso: ./validate.sh

echo "╔═══════════════════════════════════════════╗"
echo "║   Validación del Proyecto - Checklist    ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

CHECKS_PASSED=0
CHECKS_FAILED=0

# Función para validar
validate() {
    local description=$1
    local command=$2
    
    echo -n "Validando $description... "
    
    if eval "$command" &> /dev/null; then
        echo -e "${GREEN}✓${NC}"
        ((CHECKS_PASSED++))
    else
        echo -e "${RED}✗${NC}"
        ((CHECKS_FAILED++))
    fi
}

echo -e "${YELLOW}🔍 Validaciones del Sistema${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

validate "Java instalado" "java -version"
validate "Maven instalado" "mvn --version"
validate "Docker instalado" "docker --version"
validate "Docker Compose instalado" "docker-compose --version"

echo ""
echo -e "${YELLOW}🔍 Estructura del Proyecto${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

validate "pom.xml existe" "test -f pom.xml"
validate "Dockerfile existe" "test -f Dockerfile"
validate "docker-compose.yml existe" "test -f docker-compose.yml"
validate "Código fuente existe" "test -d src/main/java"
validate "Recursos existentes" "test -f src/main/resources/application.properties"

echo ""
echo -e "${YELLOW}🔍 Archivos de Documentación${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

validate "README.md existe" "test -f README.md"
validate "GUIA_DOCKER.md existe" "test -f GUIA_DOCKER.md"
validate "test_api.sh existe" "test -f test_api.sh"
validate ".dockerignore existe" "test -f .dockerignore"

echo ""
echo -e "${YELLOW}📦 Compilación${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -n "Compilando proyecto... "
if mvn clean package -q -DskipTests &> /dev/null; then
    echo -e "${GREEN}✓${NC}"
    ((CHECKS_PASSED++))
    
    validate "JAR generado" "test -f target/servicio-inventario-1.0.0.jar"
else
    echo -e "${RED}✗${NC}"
    ((CHECKS_FAILED++))
fi

echo ""
echo -e "${YELLOW}🐳 Docker${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -n "Construyendo imagen Docker... "
if docker build -t servicio-inventario:test . &> /dev/null; then
    echo -e "${GREEN}✓${NC}"
    ((CHECKS_PASSED++))
    
    validate "Imagen en repositorio local" "docker images | grep -q servicio-inventario"
    
    # Limpiar
    docker rmi servicio-inventario:test &> /dev/null
else
    echo -e "${RED}✗${NC}"
    ((CHECKS_FAILED++))
fi

echo ""
echo "╔═══════════════════════════════════════════╗"
echo -e "║  Validaciones Exitosas: ${GREEN}$CHECKS_PASSED${NC}              ║"
echo -e "║  Validaciones Fallidas: ${RED}$CHECKS_FAILED${NC}              ║"
echo "╚═══════════════════════════════════════════╝"

if [ $CHECKS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}✓ ¡Proyecto validado exitosamente!${NC}"
    echo ""
    echo "Próximos pasos:"
    echo "  1. docker build -t servicio-inventario:1.0.0 ."
    echo "  2. docker run -p 8080:8080 servicio-inventario:1.0.0"
    echo "  3. ./test_api.sh"
    exit 0
else
    echo -e "\n${RED}✗ Hay errores que corregir${NC}"
    exit 1
fi
