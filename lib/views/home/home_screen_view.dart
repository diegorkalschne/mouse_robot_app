import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../config/routes/local_routes.dart';
import '../../models/device_model.dart';
import '../../services/locator.dart';
import '../../stores/devices_store.dart';
import '../../widgets/cards/card_device.dart';
import '../../widgets/cs_appbar.dart';
import '../../widgets/cs_floating_action_button.dart';
import '../../widgets/cs_icon.dart';
import '../../widgets/cs_loading_progress.dart';
import '../../widgets/no_info_widget.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final devicesStore = locator<DevicesStore>();

  @override
  void initState() {
    super.initState();

    devicesStore.loadDevices();
  }

  void onPressedNewDevice() async {
    final response = await Navigator.of(context).pushNamed(LocalRoutes.ADD_DEVICE);

    if (response is DeviceModel) {
      devicesStore.addDevice(response);
    }
  }

  void onPressedDevice(DeviceModel device) {
    Navigator.of(context).pushNamed(LocalRoutes.MOUSE_ROBOT, arguments: device);
  }

  void onEditDevice(DeviceModel device) async {
    final clone = device.clone();

    final response = await Navigator.of(context).pushNamed(LocalRoutes.ADD_DEVICE, arguments: clone);

    if (response is DeviceModel) {
      devicesStore.replaceDevice(device, response);
    }
  }

  void onRemoveDevice(DeviceModel device) {
    devicesStore.removeDevice(device);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CsAppbar(title: 'Dispositivos'),
      floatingActionButton: CsFloatingActionButton(
        icon: CsIcon(icon: Icons.add),
        tooltip: 'Novo Dispositivo',
        onPressed: onPressedNewDevice,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Observer(
          builder: (_) {
            if (devicesStore.loading) {
              return const CsLoadingProgress.fetching();
            }

            if (devicesStore.devices.isEmpty && !devicesStore.loading) {
              return NoInfoWidget(
                message: 'Nenhum dispositivo adicionado',
                labelCallback: 'Adicionar Dispositivo',
                callback: onPressedNewDevice,
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(0).copyWith(top: 10),
              itemCount: devicesStore.devices.length,
              itemBuilder: (_, index) {
                final device = devicesStore.devices[index];

                return CardDevice(
                  device: device,
                  onPressed: onPressedDevice,
                  onEdit: onEditDevice,
                  onRemove: onRemoveDevice,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 10),
            );
          },
        ),
      ),
    );
  }
}
