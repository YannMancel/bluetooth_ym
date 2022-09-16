import 'package:bluetooth_ym/src/_src.dart';

extension BluetoothStateExt on BluetoothState {
  bool get isOn {
    return maybeWhen<bool>(
      on: () => true,
      orElse: () => false,
    );
  }
}
