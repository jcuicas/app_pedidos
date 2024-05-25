import 'package:app_pedidos/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dashboard extends StatefulWidget {
  final String id;
  final String accessToken;
  final String tokenType;
  final String userEmail;

  const Dashboard({
    super.key,
    required this.id,
    required this.accessToken,
    required this.tokenType,
    required this.userEmail,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final supabase = Supabase.instance.client;

  late Future<Profile> userProfile;

  Future<Profile> obtenerPerfil() async {
    final response =
        await supabase.from('profiles').select().eq('id', widget.id);

    debugPrint(response.toString());

    return Future.error('Falló la conexión');
  }

  @override
  void initState() {
    super.initState();

    obtenerPerfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(
        userEmail: widget.userEmail,
      ),
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
              color: Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: Text(
                  'Categorias',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/categorias.png'),
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
                  'Historico de pedidos',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/pedidos.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 3.0),
            child: Card(
              color: Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: Text(
                  'Clientes',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/clientes.png'),
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
}
