import 'dart:convert';

import 'package:mobx/mobx.dart';

import '../config/constants.dart';
import '../models/device_model.dart';
import '../services/dialog_service.dart';
import '../services/shared_service.dart';

part 'devices_store.g.dart';

class DevicesStore = _DevicesStore with _$DevicesStore;

abstract class _DevicesStore with Store {
  @observable
  bool loading = false;

  @observable
  ObservableList<DeviceModel> _devices = ObservableList();

  @computed
  List<DeviceModel> get devices => [..._devices];

  @action
  void setLoading({required bool value}) {
    loading = value;
  }

  @action
  void setDevices(List<DeviceModel> devices) {
    _devices = devices.asObservable();
  }

  @action
  void addDevice(DeviceModel device) {
    _devices.add(device);

    saveDevices();
  }

  @action
  void replaceDevice(DeviceModel oldDevice, DeviceModel device) {
    int indexOf = _devices.indexOf(oldDevice);

    _devices.replaceRange(indexOf, indexOf + 1, [device]);

    saveDevices();
  }

  @action
  void removeDevice(DeviceModel device) {
    _devices.remove(device);

    saveDevices();
  }

  Future<void> loadDevices() async {
    try {
      setLoading(value: true);

      final devicesJson = await SharedService().getString(SharedKeys.DEVICES);

      if (devicesJson != null) {
        List jsonResult = jsonDecode(devicesJson);

        final devices = jsonResult.map((e) => DeviceModel.fromJson(e)).toList();

        setDevices(devices);
      }
    } catch (_) {
      showSnackbar('Erro ao carregar dispositivos', seconds: 3);
    } finally {
      setLoading(value: false);
    }
  }

  Future<void> saveDevices() async {
    List devicesMap = _devices.map((e) => e.toJson()).toList();

    final json = jsonEncode(devicesMap);

    await SharedService().saveString(SharedKeys.DEVICES, json);
  }
}
