// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bluetooth_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BluetoothService {
  String get uuid => throw _privateConstructorUsedError;
  List<BluetoothCharacteristic> get characteristics =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BluetoothServiceCopyWith<BluetoothService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothServiceCopyWith<$Res> {
  factory $BluetoothServiceCopyWith(
          BluetoothService value, $Res Function(BluetoothService) then) =
      _$BluetoothServiceCopyWithImpl<$Res>;
  $Res call({String uuid, List<BluetoothCharacteristic> characteristics});
}

/// @nodoc
class _$BluetoothServiceCopyWithImpl<$Res>
    implements $BluetoothServiceCopyWith<$Res> {
  _$BluetoothServiceCopyWithImpl(this._value, this._then);

  final BluetoothService _value;
  // ignore: unused_field
  final $Res Function(BluetoothService) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? characteristics = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      characteristics: characteristics == freezed
          ? _value.characteristics
          : characteristics // ignore: cast_nullable_to_non_nullable
              as List<BluetoothCharacteristic>,
    ));
  }
}

/// @nodoc
abstract class _$$_BluetoothServiceCopyWith<$Res>
    implements $BluetoothServiceCopyWith<$Res> {
  factory _$$_BluetoothServiceCopyWith(
          _$_BluetoothService value, $Res Function(_$_BluetoothService) then) =
      __$$_BluetoothServiceCopyWithImpl<$Res>;
  @override
  $Res call({String uuid, List<BluetoothCharacteristic> characteristics});
}

/// @nodoc
class __$$_BluetoothServiceCopyWithImpl<$Res>
    extends _$BluetoothServiceCopyWithImpl<$Res>
    implements _$$_BluetoothServiceCopyWith<$Res> {
  __$$_BluetoothServiceCopyWithImpl(
      _$_BluetoothService _value, $Res Function(_$_BluetoothService) _then)
      : super(_value, (v) => _then(v as _$_BluetoothService));

  @override
  _$_BluetoothService get _value => super._value as _$_BluetoothService;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? characteristics = freezed,
  }) {
    return _then(_$_BluetoothService(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      characteristics: characteristics == freezed
          ? _value._characteristics
          : characteristics // ignore: cast_nullable_to_non_nullable
              as List<BluetoothCharacteristic>,
    ));
  }
}

/// @nodoc

class _$_BluetoothService implements _BluetoothService {
  const _$_BluetoothService(
      {required this.uuid,
      final List<BluetoothCharacteristic> characteristics = const []})
      : _characteristics = characteristics;

  @override
  final String uuid;
  final List<BluetoothCharacteristic> _characteristics;
  @override
  @JsonKey()
  List<BluetoothCharacteristic> get characteristics {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_characteristics);
  }

  @override
  String toString() {
    return 'BluetoothService(uuid: $uuid, characteristics: $characteristics)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BluetoothService &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality()
                .equals(other._characteristics, _characteristics));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(_characteristics));

  @JsonKey(ignore: true)
  @override
  _$$_BluetoothServiceCopyWith<_$_BluetoothService> get copyWith =>
      __$$_BluetoothServiceCopyWithImpl<_$_BluetoothService>(this, _$identity);
}

abstract class _BluetoothService implements BluetoothService {
  const factory _BluetoothService(
          {required final String uuid,
          final List<BluetoothCharacteristic> characteristics}) =
      _$_BluetoothService;

  @override
  String get uuid;
  @override
  List<BluetoothCharacteristic> get characteristics;
  @override
  @JsonKey(ignore: true)
  _$$_BluetoothServiceCopyWith<_$_BluetoothService> get copyWith =>
      throw _privateConstructorUsedError;
}
