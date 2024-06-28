import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:flutter/material.dart';

class HistoricoPedidios extends StatefulWidget {
  const HistoricoPedidios({super.key});

  @override
  State<HistoricoPedidios> createState() => _HistoricoPedidiosState();
}

class _HistoricoPedidiosState extends State<HistoricoPedidios> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      body: Center(
        child: Text('Historico de pedidos'),
      ),
    );
  }
}
