import 'package:flutter/material.dart';

class CsTextInfo extends StatelessWidget {
  const CsTextInfo({
    this.label,
    required this.description,
    this.isColumn = false,
    this.expanded = true,
    this.icon,
    super.key,
  });

  final String? label;
  final String description;
  final bool isColumn;
  final bool expanded;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: isColumn ? Axis.vertical : Axis.horizontal,
      mainAxisSize: isColumn ? MainAxisSize.min : MainAxisSize.max,
      crossAxisAlignment: isColumn ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 5),
            ],
            if (label != null) ...[
              Text(
                label!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        Flexible(
          fit: expanded && !isColumn ? FlexFit.tight : FlexFit.loose,
          child: Text(
            description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
