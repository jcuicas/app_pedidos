import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/delegates/buscar_clientes.dart';
import 'package:app_pedidos/models/cliente.dart';
import 'package:app_pedidos/providers/obtener_datos_clientes.dart';
import 'package:flutter/material.dart';

class ListadoClientes extends StatefulWidget {
  const ListadoClientes({
    super.key,
  });

  @override
  State<ListadoClientes> createState() => _ListadoClientesState();
}

class _ListadoClientesState extends State<ListadoClientes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Cliente>> listaClientes;

  @override
  void initState() {
    super.initState();

    listaClientes = obtenerClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scaffoldKey: _scaffoldKey,
        ),
      ),
      body: FutureBuilder(
        future: listaClientes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verCLientes(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('No hay datos...'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> verCLientes(List<Cliente> datos) {
    List<Widget> clientes = [];

    clientes.add(
      Card(
        child: ListTile(
          title: Text(
            'Lista de clientes',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: BuscarCliente(listaClientes: datos),
              );
            },
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );

    for (var item in datos) {
      clientes.add(Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              item.cliente.substring(0, 2),
            ),
          ),
          title: Text(item.cliente),
          subtitle: Text(item.rif),
          trailing: Text(item.grupoCliente),
        ),
      ));
    }

    return clientes;
  }
}
