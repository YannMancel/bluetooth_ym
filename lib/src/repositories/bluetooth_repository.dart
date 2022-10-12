import 'dart:async';

import 'package:bluetooth_ym/src/_src.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as bluetooth_lib;
import 'package:meta/meta.dart' show protected;

typedef DeviceWrappers = Map<BluetoothDevice, bluetooth_lib.BluetoothDevice>;
typedef ServiceWrappers = Map<BluetoothService, bluetooth_lib.BluetoothService>;
typedef CharacteristicWrappers
    = Map<BluetoothCharacteristic, bluetooth_lib.BluetoothCharacteristic>;

class BluetoothRepository implements BluetoothRepositoryInterface {
  BluetoothRepository({bool isDebugMode = false}) {
    _isDebugMode = isDebugMode;
    _deviceWrappers = Map.identity();
    _serviceWrappers = Map.identity();
    _characteristicWrappers = Map.identity();
  }

  late final bool _isDebugMode;
  late final DeviceWrappers _deviceWrappers;
  late final ServiceWrappers _serviceWrappers;
  late final CharacteristicWrappers _characteristicWrappers;

  @protected
  static bluetooth_lib.FlutterBluePlus get _instance {
    return bluetooth_lib.FlutterBluePlus.instance;
  }

  @protected
  bluetooth_lib.BluetoothDevice _searchDevice(BluetoothDevice device) {
    if (!_deviceWrappers.containsKey(device)) {
      throw Exception('Device is not present.');
    }
    return _deviceWrappers[device]!;
  }

  @protected
  bluetooth_lib.BluetoothService _searchService(
    BluetoothService service,
  ) {
    if (!_serviceWrappers.containsKey(service)) {
      throw Exception('Service is not present.');
    }
    return _serviceWrappers[service]!;
  }

  @protected
  bluetooth_lib.BluetoothCharacteristic _searchCharacteristic(
    BluetoothCharacteristic characteristic,
  ) {
    if (!_characteristicWrappers.containsKey(characteristic)) {
      throw Exception('Characteristic is not present.');
    }
    return _characteristicWrappers[characteristic]!;
  }

  @protected
  void _logScanResult(bluetooth_lib.ScanResult scanResult) {
    if (_isDebugMode) {
      print('''
        ------------------------------------------------------------------------
          BluetoothDevice device:
            - id ${scanResult.device.id}
            - hashCode ${scanResult.device.id.hashCode}
            - name ${scanResult.device.name}
            - type ${scanResult.device.type}
          AdvertisementData advertisementData:
            - localName ${scanResult.advertisementData.localName}
            - txPowerLevel ${scanResult.advertisementData.txPowerLevel}
            - connectable ${scanResult.advertisementData.connectable}
            - manufacturerData ${scanResult.advertisementData.manufacturerData}
            - serviceData ${scanResult.advertisementData.serviceData}
            - serviceUuids ${scanResult.advertisementData.serviceUuids}
          int rssi:
            - rssi ${scanResult.rssi}
          DateTime timeStamp;
            - timeStamp ${scanResult.timeStamp}
        ------------------------------------------------------------------------
        ''');
    }
  }

  @protected
  void _logBluetoothService(bluetooth_lib.BluetoothService service) {
    if (_isDebugMode) {
      print('''
        ------------------------------------------------------------------------
          BluetoothService service:
            - uuid ${service.uuid}
            - deviceId ${service.deviceId}
            - isPrimary ${service.isPrimary}
            - characteristics ${service.characteristics}
            - includedServices ${service.includedServices}
        ------------------------------------------------------------------------
        ''');
    }
  }

  @protected
  void _logBluetoothCharacteristic(
    bluetooth_lib.BluetoothCharacteristic characteristic,
  ) {
    if (_isDebugMode) {
      print('''
        ------------------------------------------------------------------------
          BluetoothCharacteristic characteristic:
            - uuid ${characteristic.uuid}
            - deviceId ${characteristic.deviceId}
            - serviceUuid ${characteristic.serviceUuid}
            - secondaryServiceUuid ${characteristic.secondaryServiceUuid}
            - properties ${characteristic.properties}
            - descriptors ${characteristic.descriptors}
        ------------------------------------------------------------------------
        ''');
    }
  }

  @override
  Future<bool> get isAvailable async => _instance.isAvailable;

  @override
  Future<bool> get isOn async => _instance.isOn;

  @override
  Stream<BluetoothState> get state async* {
    final source = _instance.state;
    await for (final event in source) {
      late BluetoothState state;
      switch (event) {
        case bluetooth_lib.BluetoothState.unknown:
          state = const BluetoothState.unknown();
          break;

        case bluetooth_lib.BluetoothState.unavailable:
          state = const BluetoothState.unavailable();
          break;

        case bluetooth_lib.BluetoothState.unauthorized:
          state = const BluetoothState.unauthorized();
          break;

        case bluetooth_lib.BluetoothState.turningOn:
          state = const BluetoothState.turningOn();
          break;

        case bluetooth_lib.BluetoothState.on:
          state = const BluetoothState.on();
          break;

        case bluetooth_lib.BluetoothState.turningOff:
          state = const BluetoothState.turningOff();
          break;

        case bluetooth_lib.BluetoothState.off:
          state = const BluetoothState.off();
          break;

        default:
          state = const BluetoothState.unknown();
          break;
      }

      yield state;
    }
  }

  @override
  Stream<bool> get isScanning => _instance.isScanning;

  @override
  Future<List<BluetoothDevice>> startScan({
    Duration timeout = const Duration(seconds: 4),
  }) async {
    _deviceWrappers.clear();
    final results = await _instance.startScan(timeout: timeout);

    for (final bluetooth_lib.ScanResult scanResult in results) {
      _logScanResult(scanResult);

      final device = BluetoothDevice(
        id: scanResult.device.id.toString(),
        name: scanResult.device.name,
      );

      _deviceWrappers[device] = scanResult.device;
    }

    return _deviceWrappers.keys.toList(growable: false);
  }

  @override
  Future<void> stopScan() async => _instance.stopScan();

  @override
  Future<void> connect(BluetoothDevice device) async {
    final selectedDevice = _searchDevice(device);
    await selectedDevice.connect();
  }

  @override
  Future<void> disconnect(BluetoothDevice device) async {
    final selectedDevice = _searchDevice(device);
    await selectedDevice.disconnect();
    _serviceWrappers.clear();
    _characteristicWrappers.clear();
  }

  @override
  Future<List<BluetoothService>> getServices(BluetoothDevice device) async {
    _serviceWrappers.clear();
    final selectedDevice = _searchDevice(device);
    final servicesFromPackage = await selectedDevice.discoverServices();

    for (final serviceFromPackage in servicesFromPackage) {
      _logBluetoothService(serviceFromPackage);

      final service = BluetoothService(
        uuid: serviceFromPackage.uuid.toString(),
      );

      _serviceWrappers[service] = serviceFromPackage;
    }

    return _serviceWrappers.keys.toList(growable: false);
  }

  @override
  Future<List<BluetoothCharacteristic>> getCharacteristics(
    BluetoothService service,
  ) async {
    final selectedService = _searchService(service);
    final characteristicsFromPackage = selectedService.characteristics;

    final CharacteristicWrappers characteristics = Map.identity();
    for (final characteristicFromPackage in characteristicsFromPackage) {
      _logBluetoothCharacteristic(characteristicFromPackage);

      final characteristic = BluetoothCharacteristic(
        uuid: characteristicFromPackage.uuid.toString(),
      );

      characteristics[characteristic] = characteristicFromPackage;
    }

    _characteristicWrappers.addAll(characteristics);

    return characteristics.keys.toList(growable: false);
  }

  @override
  Future<List<int>> readCharacteristics(
    BluetoothCharacteristic characteristic,
  ) async {
    final selectedCharacteristic = _searchCharacteristic(characteristic);
    return selectedCharacteristic.read();
  }

  @override
  Future<void> writeCharacteristics(
    BluetoothCharacteristic characteristic, {
    required List<int> values,
    bool withoutResponse = false,
  }) async {
    final selectedCharacteristic = _searchCharacteristic(characteristic);

    //TODO Remove from this method
/*    await selectedCharacteristic.setNotifyValue(true);
    selectedCharacteristic.value.listen((values) {
      print('''
      --------------------------------
      $values
      --------------------------------
      ''');
    });*/

    return selectedCharacteristic.write(
      values,
      withoutResponse: withoutResponse,
    );
  }
}
