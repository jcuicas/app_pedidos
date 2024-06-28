import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/screens/categorias.dart';
import 'package:app_pedidos/screens/existencias.dart';
import 'package:app_pedidos/screens/historico_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/screens/clientes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (!GetInfoUser.of(context).conexion!) {
      getInfoUserOffline();
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scaffoldKey: _scaffoldKey,
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 3.0),
            child: Card(
              color: const Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: const Text(
                  'Categorias',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/categorias.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListadoCategorias(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 3.0),
            child: Card(
              color: const Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: const Text(
                  'Historico de pedidos',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/pedidos.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoricoPedidios(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 3.0),
            child: Card(
              color: const Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: const Text(
                  'Clientes',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/clientes.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListadoClientes(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 3.0),
            child: Card(
              color: Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: Text(
                  'Existencias',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/existencias.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListadoExistencias(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          'Pedidos',
          style: TextStyle(
            color: Color(0xffffffff),
          ),
        ),
        icon: Icon(
          Icons.thumb_up_alt,
          color: Color(0xffffffff),
        ),
        backgroundColor: Color(0xffec1c24),
      ),
    );
  }

  void getInfoUserOffline() {
    GetInfoUser.of(context).setId('');
    GetInfoUser.of(context).setAccessToken('');
    GetInfoUser.of(context).setTokenType('');
    GetInfoUser.of(context).setEmail('jhondoe@gmail.com');
    GetInfoUser.of(context).setFullName('Jhon Doe');
  }
}
