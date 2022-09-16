import 'package:freezed_annotation/freezed_annotation.dart'
    show DeepCollectionEquality, JsonKey, freezed;

part 'bluetooth_device.freezed.dart';

@freezed
class BluetoothDevice with _$BluetoothDevice {
  const factory BluetoothDevice({
    required String id,
    required String name,
  }) = _BluetoothDevice;
}
