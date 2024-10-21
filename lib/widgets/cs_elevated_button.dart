import 'package:flutter/material.dart';

class CsElevatedButton extends StatelessWidget {
  const CsElevatedButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.expanded = false,
    this.labelAlign,
    this.height = 45,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  const CsElevatedButton.expanded({
    required this.label,
    this.onPressed,
    this.icon,
    this.labelAlign,
    this.height = 45,
    this.alignment = Alignment.centerLeft,
    super.key,
  }) : expanded = true;

  final String label;
  final VoidCallback? onPressed;
  final bool expanded;
  final TextAlign? labelAlign;
  final Widget? icon;
  final double height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: expanded ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(theme.colorScheme.secondary),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          alignment: alignment,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 5),
            ],
            Text(
              label,
              textAlign: labelAlign,
              style: TextStyle(
                color: theme.colorScheme.surface,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
