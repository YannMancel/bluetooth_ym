import 'package:bluetooth_ym/src/_src.dart';

abstract class BluetoothYM {
  static BluetoothRepositoryInterface instance({bool isDebugMode = false}) {
    return BluetoothRepository(isDebugMode: isDebugMode);
  }
}
