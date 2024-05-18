import 'package:flutter/material.dart';
import 'package:app_pedidos/screens/dashboard.dart';
import 'package:app_pedidos/models/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final supabase = Supabase.instance.client;
  late bool passwordVisible;
  late Future<Auth> loginUser;

  final emailUser = TextEditingController();
  final passwordUser = TextEditingController();

  @override
  void dispose() {
    emailUser.dispose();
    passwordUser.dispose();

    super.dispose();
  }

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
          const SizedBox(
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
        controller: emailUser,
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
        controller: passwordUser,
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
      onPressed: () {
        loginUser = authUser();
        loginUser.then(
          (value) => {
            value.accessToken.isNotEmpty
                ? goDashboard(value.accessToken, value.tokenType)
                : msgErrorLogin()
          },
        );
      },
      icon: const Icon(Icons.login_rounded),
      label: const Text('Entrar'),
    );
  }

  Future<Auth> authUser() async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: emailUser.text,
        password: passwordUser.text,
      );

      //debugPrint(response.toString());

      return Auth(
        accessToken: response.session!.accessToken.toString(),
        tokenType: response.session!.tokenType.toString(),
      );
    } catch (ex) {
      return const Auth(
        accessToken: '',
        tokenType: '',
      );
    }
  }

  void goDashboard(String accessToken, String tokenType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(
          accessToken: accessToken,
          tokenType: tokenType,
        ),
      ),
    );
  }

  void msgErrorLogin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aviso importante'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Credenciales no registradas'),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.check_circle),
            label: Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
