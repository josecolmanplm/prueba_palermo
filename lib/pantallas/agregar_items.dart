import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba_palermo/entidades/ListaPrecio.dart';

import '../entidades/Datos.dart';
import '../entidades/DetalleFactura.dart';

class AgregarItemPage extends StatefulWidget {
  const AgregarItemPage({Key? key, this.title = "Agregar Item"})
      : super(key: key);
  final String title;

  @override
  State<AgregarItemPage> createState() => _AgregarItemPageState();
}

class _AgregarItemPageState extends State<AgregarItemPage> {
  List<TextEditingController> _cantidadController = [];

  List<DetalleFactura> _detalles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: Datos.productos.length,
        itemBuilder: (BuildContext context, int index) {
          _cantidadController.add(TextEditingController(text: '0'));
          List<Widget> rows = [];
          rows.add(
            Card(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  Datos.productos[index].categoria,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child:
                                      Text(Datos.productos[index].descripcion)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    '  Pu: ${_detalles.firstWhereOrNull((element) => element.codProducto == Datos.productos[index].codigo)?.PrecioUnitario ?? 0}'),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      '  Subtotal: ${_detalles.firstWhereOrNull((element) => element.codProducto == Datos.productos[index].codigo)?.SubTotal ?? 0}')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(Icons.add_circle),
                            onPressed: () {
                              double cantidad = double.tryParse(
                                      _cantidadController[index].text) ??
                                  0;
                              cantidad += 1;
                              _cantidadController[index].text =
                                  cantidad.toString();

                              _detalles.removeWhere((element) =>
                                  element.codProducto ==
                                  Datos.productos[index].codigo);
                              _detalles.add(
                                DetalleFactura(
                                  NroFactura: 'xxx',
                                  NorLinea: index,
                                  Descripcion:
                                      Datos.productos[index].descripcion,
                                  codProducto: Datos.productos[index].codigo,
                                  Cantidad: cantidad,
                                  PrecioUnitario: 0,
                                  SubTotal: 0,
                                  producto: Datos.productos[index],
                                ),
                              );

                              Datos.productos[index].listasPrecio.map((e) {
                                if (_calcularCantidadAgrupada(
                                        Datos.productos[index].categoria) >=
                                    e.cantidad) {
                                  _detalles.removeWhere((element) =>
                                      element.codProducto ==
                                      Datos.productos[index].codigo);
                                  _detalles.add(
                                    DetalleFactura(
                                      NroFactura: 'xxx',
                                      NorLinea: index,
                                      Descripcion:
                                          Datos.productos[index].descripcion,
                                      codProducto:
                                          Datos.productos[index].codigo,
                                      Cantidad: cantidad,
                                      PrecioUnitario: e.precio,
                                      SubTotal: cantidad * e.precio,
                                      producto: Datos.productos[index],
                                    ),
                                  );
                                }
                              }).toList();
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _cantidadController[index],
                            enabled: false,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                double cantidad = double.tryParse(
                                        _cantidadController[index].text) ??
                                    0;
                                cantidad -= (cantidad == 0) ? 0 : 1;
                                _cantidadController[index].text =
                                    cantidad.toString();

                                _detalles.removeWhere((element) =>
                                    element.codProducto ==
                                    Datos.productos[index].codigo);
                                _detalles.add(
                                  DetalleFactura(
                                    NroFactura: 'xxx',
                                    NorLinea: index,
                                    Descripcion:
                                        Datos.productos[index].descripcion,
                                    codProducto: Datos.productos[index].codigo,
                                    Cantidad: cantidad,
                                    PrecioUnitario: 0,
                                    SubTotal: 0,
                                    producto: Datos.productos[index],
                                  ),
                                );

                                Datos.productos[index].listasPrecio.map((e) {
                                  if (_calcularCantidadAgrupada(
                                          Datos.productos[index].categoria) >=
                                      e.cantidad) {
                                    _detalles.removeWhere((element) =>
                                        element.codProducto ==
                                        Datos.productos[index].codigo);
                                    _detalles.add(
                                      DetalleFactura(
                                        NroFactura: 'xxx',
                                        NorLinea: index,
                                        Descripcion:
                                            Datos.productos[index].descripcion,
                                        codProducto:
                                            Datos.productos[index].codigo,
                                        Cantidad: cantidad,
                                        PrecioUnitario: e.precio,
                                        SubTotal: cantidad * e.precio,
                                        producto: Datos.productos[index],
                                      ),
                                    );
                                  }
                                }).toList();
                                setState(() {});
                              },
                            )),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          );
          return Column(
            children: rows,
          );
        },
      ),
    );
  }

  double _calcularCantidadAgrupada(String categoria) {
    var grupos = _detalles
        .where((element) => element.producto.categoria == categoria)
        .groupListsBy((e) => e.producto.categoria)
        .entries
        .map((e) => e.value);

    var cantTotal = grupos.map((e) {
      return e.map((f) => f.Cantidad).sum;
    }).sum;

    return cantTotal;
  }

  // void _recalcularDetalles() {
  //   var tempDetalle = _detalles.toList();
  //   tempDetalle.mapIndexed((i, e) {
  //     var cant = _calcularCantidadAgrupada(e.producto.categoria);
  //     var listasPrecio = e.producto.listasPrecio.where((element) => element.cantidad >= cant).toList();
  //     listasPrecio.sort((a, b) => a.cantidad.compareTo(b.cantidad));
  //     listasPrecio = listasPrecio.reversed.toList();
  //
  //
  //
  //
  //
  //   }).toList();
  //
  //     if (_calcularCantidadAgrupada(Datos.productos[index].categoria) >=
  //         e.cantidad) {
  //       _detalles.removeWhere(
  //           (element) => element.codProducto == Datos.productos[index].codigo);
  //       _detalles.add(
  //         DetalleFactura(
  //           NroFactura: 'xxx',
  //           NorLinea: index,
  //           Descripcion: Datos.productos[index].descripcion,
  //           codProducto: Datos.productos[index].codigo,
  //           Cantidad: cantidad,
  //           PrecioUnitario: e.precio,
  //           SubTotal: cantidad * e.precio,
  //           producto: Datos.productos[index],
  //         ),
  //       );
  //     }
  //   }).toList();
  //   setState(() {});
  // }
}
