import 'package:bluetooth_ym/src/_src.dart';

abstract class BluetoothYM {
  static BluetoothRepositoryInterface get instance {
    return const BluetoothRepository();
  }
}
