import 'Producto.dart';

class DetalleFactura {
  String NroFactura;
  int NorLinea;
  String Descripcion;
  String codProducto;
  double Cantidad;
  double PrecioUnitario;
  double SubTotal;
  Producto producto;

  DetalleFactura({
    required this.NroFactura,
    required this.NorLinea,
    required this.Descripcion,
    required this.codProducto,
    required this.Cantidad,
    required this.PrecioUnitario,
    required this.SubTotal,
    required this.producto,
  });
}
