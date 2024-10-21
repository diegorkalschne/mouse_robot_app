import 'package:flutter/material.dart';

class CsFloatingActionButton extends StatelessWidget {
  const CsFloatingActionButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: theme.primaryColor,
      child: icon,
    );
  }
}
