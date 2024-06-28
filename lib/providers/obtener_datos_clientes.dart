import 'package:app_pedidos/models/cliente.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Cliente>> obtenerClientes() async {
  final response = await supabase.from('clientes').select();

  List<Cliente> clientes = [];

  if (response.isNotEmpty) {
    for (var item in response) {
      clientes.add(
        Cliente(
          id: item['id'].toString(),
          cliente: item['cliente'],
          rif: item['rif'],
          grupoCliente: item['grupo_cliente'],
        ),
      );
    }

    return clientes;
  } else {
    return Future.error('Falló de conexióm');
  }
}
