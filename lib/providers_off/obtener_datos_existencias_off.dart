import 'dart:convert';

import 'package:app_pedidos/models/productos.dart';
import 'package:app_pedidos/storage/product_storage.dart';

final productStorage = ProductStorage();

Future<List<Producto>> obtenerProductosLocal() async {
  final response = await productStorage.readProducts();

  List<Producto> productos = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      productos.add(
        Producto(
          id: item['id'].toString(),
          codigo: item['codigo'],
          producto: item['producto'],
          idCategoria: item['idcategoria'].toString(),
          existencia: item['existencia'].toString(),
        ),
      );
    }
  }

  return productos;
}