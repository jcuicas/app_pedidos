import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}
