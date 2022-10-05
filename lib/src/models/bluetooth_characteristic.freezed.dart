// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bluetooth_characteristic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BluetoothCharacteristic {
  String get uuid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BluetoothCharacteristicCopyWith<BluetoothCharacteristic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothCharacteristicCopyWith<$Res> {
  factory $BluetoothCharacteristicCopyWith(BluetoothCharacteristic value,
          $Res Function(BluetoothCharacteristic) then) =
      _$BluetoothCharacteristicCopyWithImpl<$Res>;
  $Res call({String uuid});
}

/// @nodoc
class _$BluetoothCharacteristicCopyWithImpl<$Res>
    implements $BluetoothCharacteristicCopyWith<$Res> {
  _$BluetoothCharacteristicCopyWithImpl(this._value, this._then);

  final BluetoothCharacteristic _value;
  // ignore: unused_field
  final $Res Function(BluetoothCharacteristic) _then;

  @override
  $Res call({
    Object? uuid = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_BluetoothCharacteristicCopyWith<$Res>
    implements $BluetoothCharacteristicCopyWith<$Res> {
  factory _$$_BluetoothCharacteristicCopyWith(_$_BluetoothCharacteristic value,
          $Res Function(_$_BluetoothCharacteristic) then) =
      __$$_BluetoothCharacteristicCopyWithImpl<$Res>;
  @override
  $Res call({String uuid});
}

/// @nodoc
class __$$_BluetoothCharacteristicCopyWithImpl<$Res>
    extends _$BluetoothCharacteristicCopyWithImpl<$Res>
    implements _$$_BluetoothCharacteristicCopyWith<$Res> {
  __$$_BluetoothCharacteristicCopyWithImpl(_$_BluetoothCharacteristic _value,
      $Res Function(_$_BluetoothCharacteristic) _then)
      : super(_value, (v) => _then(v as _$_BluetoothCharacteristic));

  @override
  _$_BluetoothCharacteristic get _value =>
      super._value as _$_BluetoothCharacteristic;

  @override
  $Res call({
    Object? uuid = freezed,
  }) {
    return _then(_$_BluetoothCharacteristic(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BluetoothCharacteristic implements _BluetoothCharacteristic {
  const _$_BluetoothCharacteristic({required this.uuid});

  @override
  final String uuid;

  @override
  String toString() {
    return 'BluetoothCharacteristic(uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BluetoothCharacteristic &&
            const DeepCollectionEquality().equals(other.uuid, uuid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(uuid));

  @JsonKey(ignore: true)
  @override
  _$$_BluetoothCharacteristicCopyWith<_$_BluetoothCharacteristic>
      get copyWith =>
          __$$_BluetoothCharacteristicCopyWithImpl<_$_BluetoothCharacteristic>(
              this, _$identity);
}

abstract class _BluetoothCharacteristic implements BluetoothCharacteristic {
  const factory _BluetoothCharacteristic({required final String uuid}) =
      _$_BluetoothCharacteristic;

  @override
  String get uuid;
  @override
  @JsonKey(ignore: true)
  _$$_BluetoothCharacteristicCopyWith<_$_BluetoothCharacteristic>
      get copyWith => throw _privateConstructorUsedError;
}
