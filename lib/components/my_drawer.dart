import 'package:flutter/material.dart';
import 'package:app_pedidos/components/my_user_account.dart';

class MyDrawer extends StatefulWidget {
  final String userEmail;
  final String fullName;

  const MyDrawer({
    super.key,
    required this.userEmail,
    required this.fullName,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          MyUserAccount(
            userEmail: widget.userEmail,
            fullName: widget.fullName,
          )
        ],
      ),
    );
  }
}
