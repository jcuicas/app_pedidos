import 'package:flutter/material.dart';
import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/screens/dashboard.dart';
import 'package:app_pedidos/components/my_user_account.dart';

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
                  title: Text('Inicio'),
                  trailing: Icon(
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
                  title: Text('Categorias'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset('assets/img/pedidos.png'),
                  title: Text('Historico de pedidos'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset('assets/img/clientes.png'),
                  title: Text('Clientes'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset('assets/img/existencias.png'),
                  title: Text('Existencias'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xffec1c24),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Color(0xffec1c24),
                    ),
                    title: Text('Cerrar sesión'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
