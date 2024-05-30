import 'ListaPrecio.dart';

class Producto {
  String codigo;
  String descripcion;
  String categoria;
  List<ListaPrecio> listasPrecio;

  Producto({
    required this.codigo,
    required this.descripcion,
    required this.categoria,
    required this.listasPrecio,
  });
}
