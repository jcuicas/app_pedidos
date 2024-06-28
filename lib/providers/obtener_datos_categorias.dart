import 'package:app_pedidos/models/categorias.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Categoria>> obtenerCategorias() async {
  final response = await supabase.from('categorias').select();

  List<Categoria> categorias = [];

  if (response.isNotEmpty) {
    for (var item in response) {
      categorias.add(
        Categoria(
          id: item['id'].toString(),
          categoria: item['categoria'],
        ),
      );
    }

    return categorias;
  } else {
    return Future.error('Falló de conexióm');
  }
}
