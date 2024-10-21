import 'package:flutter/material.dart';

import '../../models/device_model.dart';
import '../../services/dialog_service.dart';
import '../cs_icon.dart';
import '../cs_text_info.dart';

class CardDevice extends StatelessWidget {
  const CardDevice({
    required this.device,
    required this.onPressed,
    this.onEdit,
    this.onRemove,
    super.key,
  });

  final DeviceModel device;
  final void Function(DeviceModel) onPressed;
  final void Function(DeviceModel)? onEdit;
  final void Function(DeviceModel)? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(device),
      direction: onRemove == null ? DismissDirection.none : DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
        ),
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: CsIcon(icon: Icons.delete_forever),
      ),
      onDismissed: (_) {
        onRemove!(device);
        showSnackbar('Dispositivo removido', seconds: 3);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 100),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(0),
          child: InkWell(
            onTap: () => onPressed(device),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CsTextInfo(
                          label: 'Nome: ',
                          description: device.name!,
                          icon: CsIcon(icon: Icons.monitor, color: theme.primaryColor),
                        ),
                        CsTextInfo(
                          label: 'Link: ',
                          description: device.linkConnection!,
                          icon: CsIcon(icon: Icons.link, color: theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  if (onEdit != null) ...[
                    IconButton(
                      onPressed: () => onEdit!(device),
                      icon: CsIcon(icon: Icons.edit, color: Colors.yellow.shade700),
                      tooltip: 'Editar Dispositivo',
                    )
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
