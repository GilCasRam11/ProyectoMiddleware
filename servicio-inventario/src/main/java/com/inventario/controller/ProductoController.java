package com.inventario.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.inventario.entity.Producto;
import com.inventario.service.ProductoService;

@RestController
@RequestMapping("/api/productos")
public class ProductoController {

    private final ProductoService productoService;

    public ProductoController(ProductoService productoService) {
        this.productoService = productoService;
    }

    // ¿Cómo se implementa un endpoint POST en Spring Boot para crear un nuevo producto,
    // validando que el nombre no esté vacío y devolviendo un código de estado 201 Created?
    // Respuesta: Usar @PostMapping, validar en el servicio, devolver ResponseEntity.status(CREATED)
    @PostMapping
    public ResponseEntity<Producto> crear(@RequestBody Producto producto) {
        try {
            Producto productoCreado = productoService.crear(producto);
            return ResponseEntity.status(HttpStatus.CREATED).body(productoCreado);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // GET obtener todos los productos
    @GetMapping
    public ResponseEntity<List<Producto>> obtenerTodos() {
        List<Producto> productos = productoService.obtenerTodos();
        return ResponseEntity.ok(productos);
    }

    // GET obtener producto por ID
    @GetMapping("/{id}")
    public ResponseEntity<Producto> obtenerPorId(@PathVariable Long id) {
        return productoService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // GET obtener producto por código
    @GetMapping("/codigo/{codigo}")
    public ResponseEntity<Producto> obtenerPorCodigo(@PathVariable String codigo) {
        return productoService.obtenerPorCodigo(codigo)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // PUT actualizar producto existente
    @PutMapping("/{id}")
    public ResponseEntity<Producto> actualizar(@PathVariable Long id, @RequestBody Producto producto) {
        try {
            return productoService.actualizar(id, producto)
                    .map(ResponseEntity::ok)
                    .orElseGet(() -> ResponseEntity.notFound().build());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // DELETE eliminar producto por ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        if (productoService.eliminar(id)) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
