import 'package:freezed_annotation/freezed_annotation.dart'
    show freezed, optionalTypeArgs;

part 'bluetooth_state.freezed.dart';

@freezed
class BluetoothState with _$BluetoothState {
  const factory BluetoothState.unknown() = _Unknown;
  const factory BluetoothState.unavailable() = _Unavailable;
  const factory BluetoothState.unauthorized() = _Unauthorized;
  const factory BluetoothState.turningOn() = _TurningOn;
  const factory BluetoothState.on() = _On;
  const factory BluetoothState.turningOff() = _TurningOff;
  const factory BluetoothState.off() = _Off;
}
