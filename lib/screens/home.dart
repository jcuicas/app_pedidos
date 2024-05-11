import 'package:flutter/material.dart';
import 'package:app_pedidos/screens/login.dart';
import 'package:app_pedidos/screens/dashboard.dart';

class HomeScreen extends StatefulWidget {
  final String titulo;

  const HomeScreen({
    super.key,
    required this.titulo,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool conexion = true;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/daf.png'),
        backgroundColor: Color(0xff000000),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xffec1c24),
            width: 3.0,
          ),
        ),
        elevation: 4,
      ),
      body: conexion ? Login() : Dashboard(),
      backgroundColor: Colors.grey[200],
    );
  }
}
