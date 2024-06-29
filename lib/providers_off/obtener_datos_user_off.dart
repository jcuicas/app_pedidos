import 'dart:convert';

import 'package:app_pedidos/models/user.dart';
import 'package:app_pedidos/storage/user_storage.dart';

final userStorage = UserStorage();

Future<List<User>> obtenerUsuarios() async {
  final response = await userStorage.readUser();

  List<User> usuarios = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      usuarios.add(
        User(
          id: item['id'],
          fullName: item['full_name'],
          userEmail: item['email'],
        ),
      );
    }
  }

  return usuarios;
}
