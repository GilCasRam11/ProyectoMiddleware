#!/bin/bash

# Script de prueba automatizada para los endpoints CRUD
# Uso: ./test_api.sh

API_URL="http://localhost:8080/api/productos"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}╔════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║   Test CRUD API - Servicio Inventario  ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════╝${NC}\n"

# Verificar que la API está disponible
echo -e "${YELLOW}[1/7] Verificando disponibilidad de la API...${NC}"
if ! curl -s "$API_URL" > /dev/null; then
    echo -e "${RED}✗ API no disponible en $API_URL${NC}"
    echo -e "${RED}Asegúrate de que el contenedor está corriendo:${NC}"
    echo "docker run -p 8080:8080 servicio-inventario:1.0.0"
    exit 1
fi
echo -e "${GREEN}✓ API disponible${NC}\n"

# 1. CREATE - Crear primer producto
echo -e "${YELLOW}[2/7] CREATE - Creando primer producto...${NC}"
RESPONSE1=$(curl -s -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "codigo": "LAPTOP001",
    "nombre": "Laptop Dell XPS",
    "descripcion": "Laptop de alta performance",
    "precio": 1299.99,
    "cantidad": 5
  }')

PRODUCTO_ID=$(echo "$RESPONSE1" | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)

if [ -z "$PRODUCTO_ID" ]; then
    echo -e "${RED}✗ Error al crear producto${NC}"
    echo "$RESPONSE1"
    exit 1
fi

echo -e "${GREEN}✓ Producto creado con ID: $PRODUCTO_ID${NC}"
echo "$RESPONSE1" | jq . 2>/dev/null || echo "$RESPONSE1"
echo ""

# 2. CREATE - Crear segundo producto
echo -e "${YELLOW}[3/7] CREATE - Creando segundo producto...${NC}"
RESPONSE2=$(curl -s -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "codigo": "MOUSE001",
    "nombre": "Mouse Inalámbrico",
    "descripcion": "Mouse gamer con RGB",
    "precio": 49.99,
    "cantidad": 20
  }')

PRODUCTO_ID_2=$(echo "$RESPONSE2" | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)
echo -e "${GREEN}✓ Segundo producto creado con ID: $PRODUCTO_ID_2${NC}"
echo ""

# 3. READ - Obtener todos los productos
echo -e "${YELLOW}[4/7] READ - Obteniendo todos los productos...${NC}"
RESPONSE3=$(curl -s -X GET "$API_URL")
TOTAL_PRODUCTOS=$(echo "$RESPONSE3" | grep -o '"id"' | wc -l)
echo -e "${GREEN}✓ Total de productos: $TOTAL_PRODUCTOS${NC}"
echo "$RESPONSE3" | jq . 2>/dev/null || echo "$RESPONSE3"
echo ""

# 4. READ - Obtener producto por ID
echo -e "${YELLOW}[5/7] READ - Obteniendo producto por ID ($PRODUCTO_ID)...${NC}"
RESPONSE4=$(curl -s -X GET "$API_URL/$PRODUCTO_ID")
echo -e "${GREEN}✓ Producto obtenido${NC}"
echo "$RESPONSE4" | jq . 2>/dev/null || echo "$RESPONSE4"
echo ""

# 5. READ - Obtener producto por código
echo -e "${YELLOW}[6/7] UPDATE - Actualizando producto...${NC}"
RESPONSE5=$(curl -s -X PUT "$API_URL/$PRODUCTO_ID" \
  -H "Content-Type: application/json" \
  -d '{
    "codigo": "LAPTOP001",
    "nombre": "Laptop Dell XPS 15",
    "descripcion": "Laptop de ultra alta performance",
    "precio": 1499.99,
    "cantidad": 3
  }')
echo -e "${GREEN}✓ Producto actualizado${NC}"
echo "$RESPONSE5" | jq . 2>/dev/null || echo "$RESPONSE5"
echo ""

# 6. DELETE - Eliminar un producto
echo -e "${YELLOW}[7/7] DELETE - Eliminando producto...${NC}"
DELETE_RESPONSE=$(curl -s -w "\n%{http_code}" -X DELETE "$API_URL/$PRODUCTO_ID_2")
HTTP_CODE=$(echo "$DELETE_RESPONSE" | tail -n 1)

if [ "$HTTP_CODE" = "204" ]; then
    echo -e "${GREEN}✓ Producto eliminado correctamente (HTTP 204)${NC}"
else
    echo -e "${RED}✗ Error al eliminar producto (HTTP $HTTP_CODE)${NC}"
fi

# Resumen final
echo -e "\n${YELLOW}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║    ✓ Todas las pruebas completadas     ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════╝${NC}"
