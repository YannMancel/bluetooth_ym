import 'dart:async';

import 'package:bluetooth_ym/src/_src.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as bluetooth_lib;
import 'package:meta/meta.dart' show protected;

class BluetoothRepository implements BluetoothRepositoryInterface {
  const BluetoothRepository({bool isDebugMode = false})
      : _isDebugMode = isDebugMode;

  final bool _isDebugMode;

  @protected
  static bluetooth_lib.FlutterBluePlus get _instance {
    return bluetooth_lib.FlutterBluePlus.instance;
  }

  @protected
  Future<bluetooth_lib.BluetoothDevice> _searchDevice(
    BluetoothDevice device,
  ) async {
    return (await _instance.scanResults.first)
        .where((scanResult) => scanResult.device.id.toString() == device.id)
        .first
        .device;
  }

  @protected
  void _logScanResult(bluetooth_lib.ScanResult scanResult) {
    if (_isDebugMode) {
      print('''
        ------------------------------------------------------------------------
          BluetoothDevice device:
            - id ${scanResult.device.id}
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
    final results = await _instance.startScan(timeout: timeout);

    final devices = List<BluetoothDevice>.empty(growable: true);
    for (final bluetooth_lib.ScanResult scanResult in results) {
      _logScanResult(scanResult);

      final device = BluetoothDevice(
        id: scanResult.device.id.toString(),
        name: scanResult.device.name,
      );
      devices.add(device);
    }

    return devices;
  }

  @override
  Future<void> stopScan() async => _instance.stopScan();

  @override
  Future<void> connect(BluetoothDevice device) async {
    final selectedDevice = await _searchDevice(device);
    await selectedDevice.connect();
  }

  @override
  Future<void> disconnect(BluetoothDevice device) async {
    final selectedDevice = await _searchDevice(device);
    await selectedDevice.disconnect();
  }

  @override
  Future<List<BluetoothService>> getServices(BluetoothDevice device) async {
    final selectedDevice = await _searchDevice(device);
    final servicesFromPackage = await selectedDevice.discoverServices();

    final services = List<BluetoothService>.empty(growable: true);
    for (final serviceFromPackage in servicesFromPackage) {
      _logBluetoothService(serviceFromPackage);

      final service = BluetoothService(
        uuid: serviceFromPackage.uuid.toString(),
      );
      services.add(service);
    }

    return services;
  }

  // Read and write characteristics --------------------------------------------

  // TODO: update method
  Future<void> showCharacteristics({
    required bluetooth_lib.BluetoothService service,
  }) async {
    // Reads all characteristics
    final characteristics = service.characteristics;
    for (final characteristic in characteristics) {
      List<int> value = await characteristic.read();
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
            - $value
        ------------------------------------------------------------------------
        ''');
      }
    }

    // Writes to a characteristic
    //await c.write([0x12, 0x34])
  }

  // Read and write descriptors ------------------------------------------------

  // TODO: update method
  Future<void> showDescriptors({
    required bluetooth_lib.BluetoothCharacteristic characteristic,
  }) async {
    // Reads all descriptors
    var descriptors = characteristic.descriptors;
    for (final bluetoothDescriptor in descriptors) {
      List<int> value = await bluetoothDescriptor.read();
      if (_isDebugMode) {
        print('''
        ------------------------------------------------------------------------
          BluetoothCharacteristic characteristic:
            - uuid ${bluetoothDescriptor.uuid}
            - deviceId ${bluetoothDescriptor.deviceId}
            - serviceUuid ${bluetoothDescriptor.serviceUuid}
            - characteristicUuid ${bluetoothDescriptor.characteristicUuid}
            - $value
        ------------------------------------------------------------------------
        ''');
      }
    }

    // Writes to a descriptor
    //await d.write([0x12, 0x34])

    // Set notifications and listen to changes
    //await characteristic.setNotifyValue(true);
    //characteristic.value.listen((value) {
    //  // do something with new value
    //});
  }
}
