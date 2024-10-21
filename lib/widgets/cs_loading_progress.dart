import 'package:flutter/material.dart';

class CsLoadingProgress extends StatelessWidget {
  const CsLoadingProgress({
    this.message,
    super.key,
  });

  const CsLoadingProgress.fetching({
    super.key,
  }) : message = 'Carregando dados...';

  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: theme.primaryColor,
            backgroundColor: theme.colorScheme.primaryContainer,
          ),
          if (message != null) ...[
            const SizedBox(height: 10),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
