import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../config/routes/local_routes.dart';
import '../../models/device_model.dart';
import '../../services/dialog_service.dart';
import '../../widgets/cs_appbar.dart';
import '../../widgets/cs_elevated_button.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_text_form_field.dart';

class AddDeviceView extends StatefulWidget {
  const AddDeviceView({
    this.device,
    super.key,
  });

  final DeviceModel? device;

  @override
  State<AddDeviceView> createState() => _AddDeviceViewState();
}

class _AddDeviceViewState extends State<AddDeviceView> {
  late final DeviceModel device;

  bool isInsert = true;

  final nameController = TextEditingController();
  final linkController = TextEditingController();

  final nameFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    isInsert = widget.device == null;

    device = widget.device ?? DeviceModel.empty();

    if (isInsert) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        initRegister();
      });
    } else {
      setInitialData();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    linkController.dispose();

    super.dispose();
  }

  void setInitialData() {
    nameController.text = device.name ?? '';
    linkController.text = device.linkConnection ?? '';
  }

  void initRegister() async {
    final args = {
      'title': 'Conectar Dispositivo',
      'callback': (data) {
        if (data != null) {
          device.linkConnection = data;
          linkController.text = data;
        }

        if (isInsert) {
          Future.delayed(const Duration(milliseconds: 300), () {
            nameFocus.requestFocus();
          });
        }

        Navigator.of(context).pop();
      },
    };

    await Navigator.of(context).pushNamed(LocalRoutes.READ_QRCODE, arguments: args);

    if (device.linkConnection == null) {
      showSnackbar('Leia o QR Code antes de continuar');

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void onPressedAdd() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!formKey.currentState!.validate()) {
      showSnackbar('Verifique os campos obrigatórios', seconds: 2);
      return;
    }

    showSnackbar('Dispositivo ${isInsert ? 'salvo' : 'atualizado'}', seconds: 2);

    Navigator.of(context).pop(device);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CsAppbar(title: '${isInsert ? 'Adicionar' : 'Editar'} Dispositivo'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CsTextFormField(
                labelText: 'Nome',
                hintText: 'Informe o nome do dispositivo...',
                controller: nameController,
                focusNode: nameFocus,
                onChanged: (name) {
                  device.name = name;
                },
                validator: (name) {
                  if (name?.isEmpty ?? true) {
                    return 'Informe o nome do dispositivo';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              CsTextFormField(
                labelText: 'Link',
                controller: linkController,
                readOnly: true,
                validator: (link) {
                  if (link?.isEmpty ?? true) {
                    return 'Informe o link de conexão';
                  }

                  return null;
                },
                suffixIcon: isInsert
                    ? null
                    : IconButton(
                        onPressed: initRegister,
                        icon: CsIcon(
                          icon: Icons.edit,
                          color: Colors.yellow.shade700,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              CsElevatedButton.expanded(
                label: '${isInsert ? 'Adicionar' : 'Atualizar'} Dispositivo',
                alignment: Alignment.center,
                onPressed: onPressedAdd,
              )
            ],
          ),
        ),
      ),
    );
  }
}
