import 'package:mobx/mobx.dart';

import '../../config/constants.dart';
import '../../models/device_model.dart';
import '../../services/shared_service.dart';

part 'mouse_robot_state.g.dart';

class MouseRobotState = _MouseRobotStateBase with _$MouseRobotState;

abstract class _MouseRobotStateBase with Store {
  _MouseRobotStateBase(this._device);

  final DeviceModel _device;

  @observable
  double _acceleratorFactor = 15;

  @computed
  double get acceleratorFactor => _acceleratorFactor;

  @computed
  double get acceleratorFactorNegative => _acceleratorFactor * -_acceleratorFactor.sign;

  @action
  void setAcceleratorFactor(double factor) {
    _acceleratorFactor = factor;

    saveAcceleratorFactor();
  }

  Future<void> saveAcceleratorFactor() async {
    await SharedService().saveDouble(SharedKeys.ACCELERATOR_FACTOR, _acceleratorFactor, suffix: '${_device.name}${_device.linkConnection}');
  }

  Future<void> loadAcceleratorFactor() async {
    final factor = await SharedService().getDouble(SharedKeys.ACCELERATOR_FACTOR, suffix: '${_device.name}${_device.linkConnection}');

    if (factor != null) {
      setAcceleratorFactor(factor);
    }
  }
}
