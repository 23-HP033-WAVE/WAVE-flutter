import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const MyAppBar({super.key, required this.titleText});

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 1.0,
      toolbarHeight: 80.0,
      centerTitle: true,
      title: Text(
        titleText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          height: 1.0,
        ),
      ),
    );
  }
}
