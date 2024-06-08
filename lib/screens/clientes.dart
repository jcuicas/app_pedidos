import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/delegates/buscar_clientes.dart';
import 'package:app_pedidos/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListadoClientes extends StatefulWidget {
  final String id;
  final String accessToken;
  final String tokenType;
  final String userEmail;
  final String fullName;

  const ListadoClientes({
    super.key,
    required this.id,
    required this.accessToken,
    required this.tokenType,
    required this.userEmail,
    required this.fullName,
  });

  @override
  State<ListadoClientes> createState() => _ListadoClientesState();
}

class _ListadoClientesState extends State<ListadoClientes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final supabase = Supabase.instance.client;

  late final Future<List<Cliente>> listaClientes;

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

  @override
  void initState() {
    super.initState();

    listaClientes = obtenerClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(
        id: widget.id,
        accessToken: widget.accessToken,
        tokenType: widget.tokenType,
        userEmail: widget.userEmail,
        fullName: widget.fullName,
      ),
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
            'Listado de clientes',
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
