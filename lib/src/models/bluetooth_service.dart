import 'package:freezed_annotation/freezed_annotation.dart'
    show DeepCollectionEquality, JsonKey, freezed;

part 'bluetooth_service.freezed.dart';

@freezed
class BluetoothService with _$BluetoothService {
  const factory BluetoothService({required String uuid}) = _BluetoothService;
}
