import 'package:freezed_annotation/freezed_annotation.dart'
    show DeepCollectionEquality, JsonKey, freezed;

part 'bluetooth_characteristic.freezed.dart';

@freezed
class BluetoothCharacteristic with _$BluetoothCharacteristic {
  const factory BluetoothCharacteristic({required String uuid}) =
      _BluetoothCharacteristic;
}
