import 'dart:convert';

import 'package:app_pedidos/models/cliente.dart';
import 'package:app_pedidos/storage/client_storage.dart';

final clientStorage = ClientStorage();

Future<List<Cliente>> obtenerClientesLocal() async {
  final response = await clientStorage.readClients();

  List<Cliente> clientes = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      clientes.add(
        Cliente(
          id: item['id'].toString(),
          cliente: item['cliente'],
          rif: item['rif'],
          grupoCliente: item['grupo_cliente'],
        ),
      );
    }
  }

  return clientes;
}