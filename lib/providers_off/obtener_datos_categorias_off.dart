import 'dart:convert';

import 'package:app_pedidos/models/categorias.dart';
import 'package:app_pedidos/storage/category_storage.dart';

final categoryStorage = CategoryStorage();

Future<List<Categoria>> obtenerCategoriasLocal() async {
  final response = await categoryStorage.readCategories();

  List<Categoria> categorias = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      categorias.add(
        Categoria(
          id: item['id'].toString(),
          categoria: item['categoria'],
        ),
      );
    }
  }

  return categorias;
}