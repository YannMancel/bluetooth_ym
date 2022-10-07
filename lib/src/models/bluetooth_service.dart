import 'package:bluetooth_ym/src/_src.dart';
import 'package:freezed_annotation/freezed_annotation.dart'
    show
        DeepCollectionEquality,
        Default,
        EqualUnmodifiableListView,
        JsonKey,
        freezed;

part 'bluetooth_service.freezed.dart';

@freezed
class BluetoothService with _$BluetoothService {
  const factory BluetoothService({
    required String uuid,
    @Default([]) List<BluetoothCharacteristic> characteristics,
  }) = _BluetoothService;
}
