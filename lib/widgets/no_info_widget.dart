import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/assets/assets_path.dart';
import 'cs_elevated_button.dart';

class NoInfoWidget extends StatelessWidget {
  const NoInfoWidget({
    required this.message,
    this.image,
    this.callback,
    this.labelCallback,
    super.key,
  }) : assert((callback == null && labelCallback == null) || (callback != null && labelCallback != null), 'Provide the \'callback\' and \'labelCallback\' parameters or leave them null');

  final String message;
  final String? image;
  final String? labelCallback;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            image ?? AssetsPath.NO_DEVICES,
            width: size.width * 0.8,
            height: size.height * 0.4,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (callback != null) ...[
            const SizedBox(height: 10),
            CsElevatedButton.expanded(
              label: labelCallback!,
              onPressed: callback,
              alignment: Alignment.center,
            ),
          ],
        ],
      ),
    );
  }
}
