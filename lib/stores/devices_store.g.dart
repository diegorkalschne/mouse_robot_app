// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DevicesStore on _DevicesStore, Store {
  Computed<List<DeviceModel>>? _$devicesComputed;

  @override
  List<DeviceModel> get devices =>
      (_$devicesComputed ??= Computed<List<DeviceModel>>(() => super.devices,
              name: '_DevicesStore.devices'))
          .value;

  late final _$loadingAtom =
      Atom(name: '_DevicesStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_devicesAtom =
      Atom(name: '_DevicesStore._devices', context: context);

  @override
  ObservableList<DeviceModel> get _devices {
    _$_devicesAtom.reportRead();
    return super._devices;
  }

  @override
  set _devices(ObservableList<DeviceModel> value) {
    _$_devicesAtom.reportWrite(value, super._devices, () {
      super._devices = value;
    });
  }

  late final _$_DevicesStoreActionController =
      ActionController(name: '_DevicesStore', context: context);

  @override
  void setLoading({required bool value}) {
    final _$actionInfo = _$_DevicesStoreActionController.startAction(
        name: '_DevicesStore.setLoading');
    try {
      return super.setLoading(value: value);
    } finally {
      _$_DevicesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDevices(List<DeviceModel> devices) {
    final _$actionInfo = _$_DevicesStoreActionController.startAction(
        name: '_DevicesStore.setDevices');
    try {
      return super.setDevices(devices);
    } finally {
      _$_DevicesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDevice(DeviceModel device) {
    final _$actionInfo = _$_DevicesStoreActionController.startAction(
        name: '_DevicesStore.addDevice');
    try {
      return super.addDevice(device);
    } finally {
      _$_DevicesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void replaceDevice(DeviceModel oldDevice, DeviceModel device) {
    final _$actionInfo = _$_DevicesStoreActionController.startAction(
        name: '_DevicesStore.replaceDevice');
    try {
      return super.replaceDevice(oldDevice, device);
    } finally {
      _$_DevicesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeDevice(DeviceModel device) {
    final _$actionInfo = _$_DevicesStoreActionController.startAction(
        name: '_DevicesStore.removeDevice');
    try {
      return super.removeDevice(device);
    } finally {
      _$_DevicesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
devices: ${devices}
    ''';
  }
}
