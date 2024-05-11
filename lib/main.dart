import 'package:flutter/material.dart';
import 'package:app_pedidos/screens/home.dart';

void main() => runApp(const MyAppPedidos());

class MyAppPedidos extends StatelessWidget {
  const MyAppPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    const String tituloApp = 'DAF C.A.';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: tituloApp,
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      home: HomeScreen(
        titulo: tituloApp,
      ),
    );
  }
}
