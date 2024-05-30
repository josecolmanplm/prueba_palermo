import 'package:prueba_palermo/entidades/ListaPrecio.dart';
import 'Producto.dart';

class Datos {
  static final List<Producto> productos = <Producto>[
    Producto(
      codigo: '1',
      descripcion: 'Coca Cola 500ml',
      categoria: 'coca',
      listasPrecio: [
        ListaPrecio(codProducto: '1', cantidad: 1, precio: 7000),
        ListaPrecio(codProducto: '1', cantidad: 5, precio: 6500),
        ListaPrecio(codProducto: '1', cantidad: 10, precio: 6000),
      ],
    ),
    Producto(
      codigo: '2',
      descripcion: 'Coca Cola 300ml',
      categoria: 'coca',
      listasPrecio: [
        ListaPrecio(codProducto: '2', cantidad: 1, precio: 5000),
        ListaPrecio(codProducto: '2', cantidad: 5, precio: 4500),
        ListaPrecio(codProducto: '2', cantidad: 10, precio: 4000),
      ],
    ),
    Producto(
      codigo: '3',
      descripcion: 'Fanta Guarana 500ml',
      categoria: 'coca',
      listasPrecio: [
        ListaPrecio(codProducto: '3', cantidad: 1, precio: 7000),
        ListaPrecio(codProducto: '3', cantidad: 5, precio: 6500),
        ListaPrecio(codProducto: '3', cantidad: 10, precio: 6000),
      ],
    ),
    Producto(
      codigo: '4',
      descripcion: 'Pepsi Cola 500ml',
      categoria: 'pepsi',
      listasPrecio: [
        ListaPrecio(codProducto: '4', cantidad: 1, precio: 6500),
        ListaPrecio(codProducto: '4', cantidad: 5, precio: 6000),
        ListaPrecio(codProducto: '4', cantidad: 10, precio: 5500),
      ],
    ),
    Producto(
      codigo: '5',
      descripcion: '7Up 500ml',
      categoria: 'pepsi',
      listasPrecio: [
        ListaPrecio(codProducto: '5', cantidad: 1, precio: 6000),
        ListaPrecio(codProducto: '5', cantidad: 5, precio: 5500),
        ListaPrecio(codProducto: '5', cantidad: 10, precio: 5000),
      ],
    ),
  ];
}
