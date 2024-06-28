import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/delegates/buscar_existencias.dart';
import 'package:app_pedidos/models/productos.dart';
import 'package:app_pedidos/providers/obtener_datos_existencias.dart';
import 'package:flutter/material.dart';

class ListadoExistencias extends StatefulWidget {
  const ListadoExistencias({super.key});

  @override
  State<ListadoExistencias> createState() => _ListadoExistenciasState();
}

class _ListadoExistenciasState extends State<ListadoExistencias> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Producto>> listaProductos;

  @override
  void initState() {
    super.initState();

    listaProductos = obtenerProductos();
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
        future: listaProductos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verExistencias(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: const Text('No hay datos'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> verExistencias(List<Producto> datos) {
    List<Widget> existencias = [];

    existencias.add(
      Card(
        child: ListTile(
          leading: const Text(
            'Lista de productos',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: BuscarExistencia(listaProductos: datos));
              },
              icon: const Icon(Icons.search)),
        ),
      ),
    );

    for (var item in datos) {
      existencias.add(Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              item.producto.substring(0, 2),
            ),
          ),
          title: Text(item.producto),
          subtitle: Text(item.codigo),
          trailing: Text('${item.existencia} uds.'),
        ),
      ));
    }

    return existencias;
  }
}
