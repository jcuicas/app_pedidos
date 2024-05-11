import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool passwordVisible;

  void toogle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(),
    );
  }

  Widget cuerpo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titulo(),
          email(),
          clave(),
          SizedBox(
            height: 18.0,
          ),
          entrar(),
        ],
      ),
    );
  }

  Widget titulo() {
    return const Text(
      'Inicio de sesión',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget email() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Escribe el correo electrónico',
        ),
        autofocus: true,
      ),
    );
  }

  Widget clave() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Escribe la contraseña',
          suffixIcon: IconButton(
            onPressed: () {
              toogle();
            },
            icon:
                Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
            color: Theme.of(context).primaryColor,
          ),
        ),
        obscureText: passwordVisible,
      ),
    );
  }

  Widget entrar() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.login_rounded),
      label: const Text('Entrar'),
    );
  }
}
