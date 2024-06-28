import 'package:app_pedidos/models/productos.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Producto>> obtenerProductos() async {
  final response = await supabase.from('productos').select('*');

  List<Producto> productos = [];

  if (response.isNotEmpty) {
    for (var item in response) {
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
    return productos;
  } else {
    return Future.error('Falló de conexióm');
  }
}
