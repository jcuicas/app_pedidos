import 'package:flutter/material.dart';

class MyUserAccount extends StatefulWidget {
  final String userEmail;

  const MyUserAccount({
    super.key,
    required this.userEmail,
  });

  @override
  State<MyUserAccount> createState() => _MyUserAccountState();
}

class _MyUserAccountState extends State<MyUserAccount> {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          color: Color(0xff000000),
          border: Border(
              bottom: BorderSide(
            color: Color(0xffec1c24),
            width: 3.0,
          ))),
      accountName: Text('José Cuicas'),
      accountEmail: Text(widget.userEmail),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Color(0xffffffff),
        child: Icon(
          Icons.supervised_user_circle_rounded,
          size: 72.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
