import 'package:bluetooth_ym/src/_src.dart';

abstract class BluetoothRepositoryInterface {
  /// Checks whether the device supports Bluetooth.
  Future<bool> get isAvailable;

  /// Checks if Bluetooth functionality is turned on.
  Future<bool> get isOn;

  /// Gets the current [BluetoothState] of the Bluetooth module.
  Stream<BluetoothState> get state;

  Stream<bool> get isScanning;

  /// Starts a scan and returns a future of [BluetoothDevice]s that will
  /// complete once the scan has finished.
  /// Once a scan is started, call [stopScan] to stop the scan and complete the
  /// returned future.
  /// [timeout] automatically stops the scan after a specified Duration.
  Future<List<BluetoothDevice>> startScan({
    Duration timeout = const Duration(seconds: 4),
  });

  /// Stops a scan for Bluetooth Low Energy devices.
  Future<void> stopScan();

  /// Establishes a connection to the Bluetooth Device via a [BluetoothDevice].
  Future<void> connect(BluetoothDevice device);

  /// Cancels connection to the Bluetooth Device via a [BluetoothDevice].
  Future<void> disconnect(BluetoothDevice device);

  /// Discovers [BluetoothService] offered by the remote [BluetoothDevice].
  Future<List<BluetoothService>> getServices(BluetoothDevice device);

  /// Discovers [BluetoothCharacteristic] offered by the remote
  /// [BluetoothService].
  Future<List<BluetoothCharacteristic>> getCharacteristics(
    BluetoothService service,
  );
}
