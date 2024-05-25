import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  final Widget? myButtonDrawer;

  const MyAppBar({
    super.key,
    this.myButtonDrawer,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/img/daf.png'),
      leading: widget.myButtonDrawer,
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
