import 'package:bluetooth_ym/bluetooth_ym.dart' show BluetoothState;
import 'package:flutter/material.dart';

class BluetoothStateLabel extends StatelessWidget {
  const BluetoothStateLabel({
    super.key,
    required this.bluetoothState,
  });

  final BluetoothState bluetoothState;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Center(
      child: Text(
        bluetoothState.when<String>(
          unknown: () => 'unknown',
          unavailable: () => 'unavailable',
          unauthorized: () => 'unauthorized',
          turningOn: () => 'turningOn',
          on: () => 'on',
          turningOff: () => 'turningOff',
          off: () => 'off',
        ),
      ),
    );
  }
}
