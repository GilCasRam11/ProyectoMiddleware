# 📤 Git - Instrucciones para Trabajo Futuro

## Estado Actual

✅ **Repositorio Inicializado**: `/Users/mac-1-/Documents/ProyectoMiddleware`  
✅ **Remoto Configurado**: `https://github.com/GilCasRam11/ProyectoMiddleware.git`  
✅ **Rama Principal**: `main`  
✅ **Commit Inicial**: Enviado con toda la documentación y código

## Commits Realizados

```bash
# Commit 1: Inicial (94cb5f8)
feat: Servicio de Inventario - Spring Boot + Docker Multi-Stage Optimizado

- Dockerfile optimizado (75% reducción)
- API CRUD completa
- Documentación completa
- Scripts de automatización
```

## Comandos Git Comunes

### Ver Estado
```bash
cd /Users/mac-1-/Documents/ProyectoMiddleware
git status
```

### Agregar Cambios
```bash
# Agregar archivo específico
git add archivo.txt

# Agregar todos los cambios
git add .
```

### Hacer Commit
```bash
git commit -m "feat: Descripción del cambio"
```

### Push a GitHub
```bash
git push origin main
```

### Pull desde GitHub
```bash
git pull origin main
```

### Ver Historial
```bash
git log --oneline
git log --graph --all --decorate
```

### Crear Rama
```bash
git checkout -b nombre-rama
git push -u origin nombre-rama
```

## Estructura del Repositorio

```
ProyectoMiddleware/
└── servicio-inventario/
    ├── Dockerfile
    ├── docker-compose.yml
    ├── README.md
    ├── GUIA_DOCKER.md
    ├── ESTRUCTURA.md
    ├── pom.xml
    ├── src/
    │   ├── main/
    │   │   ├── java/com/inventario/
    │   │   └── resources/
    │   └── test/
    ├── test_api.sh
    ├── validate.sh
    └── QUICK_START.sh
```

## Próximos Pasos

1. **Para Cambios Locales**:
   ```bash
   git add .
   git commit -m "feat/fix: Descripción"
   git push origin main
   ```

2. **Para Nuevas Funcionalidades**:
   ```bash
   git checkout -b feature/nueva-funcion
   # ... hacer cambios ...
   git add .
   git commit -m "feat: Nueva funcionalidad"
   git push -u origin feature/nueva-funcion
   # Crear Pull Request en GitHub
   ```

3. **Para Fixes**:
   ```bash
   git checkout -b fix/descripcion-fix
   # ... hacer cambios ...
   git add .
   git commit -m "fix: Descripción del fix"
   git push -u origin fix/descripcion-fix
   ```

## Configuración Git Actual

```bash
# Usuario
user.name = GilCasRam11
user.email = tu-email@example.com

# Remoto
origin = https://github.com/GilCasRam11/ProyectoMiddleware.git
```

## URL del Repositorio

🔗 **GitHub**: https://github.com/GilCasRam11/ProyectoMiddleware.git

**Clonar nuevo**:
```bash
git clone https://github.com/GilCasRam11/ProyectoMiddleware.git
```

## Archivos Ignorados (.gitignore)

El repositorio ignora automáticamente:
- `.DS_Store`
- `target/`
- `.idea/`
- `*.class`
- `*.jar` (excepto en documentación)

## Rama Principal

La rama `main` es la rama principal y está sincronizada con GitHub.

Cualquier cambio en esta rama debe estar probado y documentado.

---

**Fecha de Creación**: 12 de noviembre de 2025  
**Versión**: 1.0.0

Para más información sobre el proyecto, ver `README.md` o `GUIA_DOCKER.md`.
