//import 'dart:io';

import 'package:app_pedidos/providers/obtener_datos_clientes.dart';
import 'package:app_pedidos/screens/categorias.dart';
import 'package:app_pedidos/screens/clientes.dart';
import 'package:app_pedidos/screens/existencias.dart';
import 'package:app_pedidos/screens/historico_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/screens/dashboard.dart';
import 'package:app_pedidos/components/my_user_account.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                MyUserAccount(
                  userEmail: GetInfoUser.of(context).userEmail!,
                  fullName: GetInfoUser.of(context).fullName!,
                ),
                ListTile(
                  leading: Image.asset('assets/img/dashboard.png'),
                  title: const Text('Inicio'),
                  trailing: const Icon(
                    Icons.home,
                    color: Color(0xffec1c24),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: Color(0xffec1c24),
                ),
                ListTile(
                  leading: Image.asset('assets/img/categorias.png'),
                  title: const Text('Categorias'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoCategorias(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/pedidos.png'),
                  title: const Text('Historico de pedidos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoricoPedidios(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/clientes.png'),
                  title: const Text('Clientes'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoClientes(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/existencias.png'),
                  title: const Text('Existencias'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoExistencias(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffec1c24),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: Color(0xffec1c24),
                    ),
                    title: const Text('Cerrar sesión'),
                    onTap: () {
                      logout();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void logout() async {
    await supabase.auth.signOut();

    //exit(0); // Cerrar app en windows
    SystemNavigator.pop(); // Cerrar app en android
  }
}
