import 'package:flutter/material.dart';

class CsIcon extends StatelessWidget {
  const CsIcon({
    required this.icon,
    this.size = 24,
    this.color,
    super.key,
  });

  final IconData icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Colors.white;

    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
