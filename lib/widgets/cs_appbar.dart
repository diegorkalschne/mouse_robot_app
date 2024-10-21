import 'package:flutter/material.dart';

class CsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CsAppbar({
    required this.title,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(65);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
    );
  }
}
