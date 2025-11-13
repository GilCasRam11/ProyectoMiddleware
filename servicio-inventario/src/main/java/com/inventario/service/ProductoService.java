package com.inventario.service;

import com.inventario.entity.Producto;
import com.inventario.repository.ProductoRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ProductoService {

    private final ProductoRepository productoRepository;

    public ProductoService(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    // Obtener todos los productos
    public List<Producto> obtenerTodos() {
        return productoRepository.findAll();
    }

    // Obtener producto por ID
    public Optional<Producto> obtenerPorId(Long id) {
        return productoRepository.findById(id);
    }

    // Obtener producto por código
    public Optional<Producto> obtenerPorCodigo(String codigo) {
        return productoRepository.findByCodigo(codigo);
    }

    // Crear nuevo producto con validaciones
    public Producto crear(Producto producto) {
        validarProducto(producto);
        return productoRepository.save(producto);
    }

    // Actualizar producto existente
    public Optional<Producto> actualizar(Long id, Producto productoActualizado) {
        return productoRepository.findById(id)
                .map(existente -> {
                    validarProducto(productoActualizado);
                    existente.setCodigo(productoActualizado.getCodigo());
                    existente.setNombre(productoActualizado.getNombre());
                    existente.setDescripcion(productoActualizado.getDescripcion());
                    existente.setPrecio(productoActualizado.getPrecio());
                    existente.setCantidad(productoActualizado.getCantidad());
                    return productoRepository.save(existente);
                });
    }

    // Eliminar producto por ID
    public boolean eliminar(Long id) {
        if (productoRepository.existsById(id)) {
            productoRepository.deleteById(id);
            return true;
        }
        return false;
    }

    // Validar campos requeridos del producto
    private void validarProducto(Producto producto) {
        if (producto.getNombre() == null || producto.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del producto no puede estar vacío");
        }
        if (producto.getCodigo() == null || producto.getCodigo().trim().isEmpty()) {
            throw new IllegalArgumentException("El código del producto no puede estar vacío");
        }
        if (producto.getPrecio() == null || producto.getPrecio() <= 0) {
            throw new IllegalArgumentException("El precio debe ser mayor a 0");
        }
        if (producto.getCantidad() == null || producto.getCantidad() < 0) {
            throw new IllegalArgumentException("La cantidad no puede ser negativa");
        }
    }
}