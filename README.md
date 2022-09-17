[![badge_flutter]][link_flutter_release]

# bluetooth_ym
**Goal**: A dart package to manage bluetooth.

## Setup the project in Android studio
1. Download the project code, preferably using `git clone git@github.com:YannMancel/bluetooth_ym.git`.
2. In Android Studio, select *File* | *Open...*
3. Select the project

## Introduction
bluetooth_ym is a bluetooth package for [Flutter][link_flutter_release].
Note: This plugin is based on [FlutterBluePlus][dependencies_flutter_blue_plus].

## Cross-Platform Bluetooth LE
bluetooth_ym aims to offer the most from both platforms (iOS and Android).

Using the bluetooth_ym instance, you can scan for and connect to nearby devices ([BluetoothDevice][link_package_bluetooth_device]).
Once connected to a device, the BluetoothDevice object can discover services ([BluetoothService][link_package_bluetooth_service]).

## Usage
### Obtain an instance
```dart
  final BluetoothRepositoryInterface bluetoothYM = BluetoothYM.instance();
```

### Scan for devices
```dart
  // Start scanning
  final List<BluetoothDevice> devices = await bluetoothYM.startScan();
  
  // Stop scanning
  await bluetoothYM.stopScan();
```

### Connect to a device
```dart
  // Connect to the device
  await bluetoothYM.connect(device);
  
  // Disconnect from device
  await bluetoothYM.disconnect(device);
```

### Discover services
```dart
  final List<BluetoothService> services = await bluetoothYM.getServices(device);
```

## Getting Started

### Change the minSdkVersion for Android
flutter_blue_plus is compatible only from version 19 of Android SDK so you should change this in **android/app/build.gradle**:
```dart
  Android {
    defaultConfig {
       minSdkVersion: 19
```
### Add permissions for Bluetooth
We need to add the permission to use Bluetooth and access location:

#### **Android**
In the **android/app/src/main/AndroidManifest.xml** let’s add:

```xml 
  <uses-permission android:name="android.permission.BLUETOOTH" />  
  <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />  
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>  
  
  <application
    ...
  </application>
```
#### **IOS**
In the **ios/Runner/Info.plist** let’s add:

```dart 
	<dict>  
	    <key>NSBluetoothAlwaysUsageDescription</key>  
	    <string>Need BLE permission</string>  
	    <key>NSBluetoothPeripheralUsageDescription</key>  
	    <string>Need BLE permission</string>  
	    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>  
	    <string>Need Location permission</string>  
	    <key>NSLocationAlwaysUsageDescription</key>  
	    <string>Need Location permission</string>  
	    <key>NSLocationWhenInUseUsageDescription</key>  
	    <string>Need Location permission</string>
```

For location permissions on iOS see more at: [https://developer.apple.com/documentation/corelocation/requesting_authorization_for_location_services][link_apple_requesting_authorization_for_location_services]

## Dependencies
* Linter
  * [lints][dependencies_lints]
* Data class generator
  * [build_runner][dependencies_build_runner]
  * [freezed][dependencies_freezed]
  * [freezed_annotation][dependencies_freezed_annotation]
* Bluetooth
  * [flutter_blue_plus][dependencies_flutter_blue_plus]
* Dart annotations
  * [meta][dependencies_meta]

[badge_flutter]: https://img.shields.io/badge/flutter-v3.3.0-blue?logo=flutter
[link_flutter_release]: https://docs.flutter.dev/development/tools/sdk/releases
[link_package_bluetooth_device]: lib/src/models/bluetooth_device.dart
[link_package_bluetooth_service]: lib/src/models/bluetooth_service.dart
[link_apple_requesting_authorization_for_location_services]: https://developer.apple.com/documentation/corelocation/requesting_authorization_for_location_services
[dependencies_lints]: https://pub.dev/packages/lints
[dependencies_build_runner]: https://pub.dev/packages/build_runner
[dependencies_freezed]: https://pub.dev/packages/freezed
[dependencies_freezed_annotation]: https://pub.dev/packages/freezed_annotation
[dependencies_flutter_blue_plus]: https://pub.dev/packages/flutter_blue_plus
[dependencies_meta]: https://pub.dev/packages/meta
