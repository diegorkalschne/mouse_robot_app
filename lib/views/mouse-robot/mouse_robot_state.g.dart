// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mouse_robot_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MouseRobotState on _MouseRobotStateBase, Store {
  Computed<double>? _$smoothFactorComputed;

  @override
  double get acceleratorFactor =>
      (_$smoothFactorComputed ??= Computed<double>(() => super.acceleratorFactor,
              name: '_MouseRobotStateBase.smoothFactor'))
          .value;
  Computed<double>? _$smoothFactorNegativeComputed;

  @override
  double get acceleratorFactorNegative => (_$smoothFactorNegativeComputed ??=
          Computed<double>(() => super.acceleratorFactorNegative,
              name: '_MouseRobotStateBase.smoothFactorNegative'))
      .value;

  late final _$_smoothFactorAtom =
      Atom(name: '_MouseRobotStateBase._smoothFactor', context: context);

  @override
  double get _acceleratorFactor {
    _$_smoothFactorAtom.reportRead();
    return super._acceleratorFactor;
  }

  @override
  set _acceleratorFactor(double value) {
    _$_smoothFactorAtom.reportWrite(value, super._acceleratorFactor, () {
      super._acceleratorFactor = value;
    });
  }

  late final _$_MouseRobotStateBaseActionController =
      ActionController(name: '_MouseRobotStateBase', context: context);

  @override
  void setAcceleratorFactor(double factor) {
    final _$actionInfo = _$_MouseRobotStateBaseActionController.startAction(
        name: '_MouseRobotStateBase.setSmoothFactor');
    try {
      return super.setAcceleratorFactor(factor);
    } finally {
      _$_MouseRobotStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
smoothFactor: ${acceleratorFactor},
smoothFactorNegative: ${acceleratorFactorNegative}
    ''';
  }
}
