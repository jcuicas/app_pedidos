import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/delegates/buscar_categorias.dart';
import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/models/categorias.dart';
import 'package:app_pedidos/providers/obtener_datos_categorias.dart';
import 'package:app_pedidos/providers_off/obtener_datos_categorias_off.dart';
import 'package:app_pedidos/storage/category_storage.dart';
import 'package:flutter/material.dart';

class ListadoCategorias extends StatefulWidget {
  const ListadoCategorias({super.key});

  @override
  State<ListadoCategorias> createState() => _ListadoCategoriasState();
}

class _ListadoCategoriasState extends State<ListadoCategorias> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Categoria>> listaCategorias;

  final categoryStorage = CategoryStorage();

  @override
  void initState() {
    super.initState();

    //listaCategorias = obtenerCategorias();
  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaCategorias = obtenerCategorias();
    } else {
      listaCategorias = obtenerCategoriasLocal();
    }

    return Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        appBar: MyAppBar(
          myButtonDrawer: MyButtonDrawer(
            scaffoldKey: _scaffoldKey,
          ),
        ),
        body: FutureBuilder(
          future: listaCategorias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: verCategorias(snapshot.data!),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('No hay datos'),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  List<Widget> verCategorias(List<Categoria> datos) {
    List<Widget> categorias = [];

    categorias.add(Card(
      child: ListTile(
        title: const Text(
          'Lista de categorias',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: BuscarCategoria(listaCategorias: datos),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ),
    ));
    for (var item in datos) {
      categorias.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                item.categoria.substring(0, 2),
              ),
            ),
            title: Text(item.categoria),
          ),
        ),
      );
    }

    categoryStorage.writeCategories(datos);

    return categorias;
  }
}
