import 'package:bluetooth_ym/bluetooth_ym.dart'
    show BluetoothDevice, BluetoothState, BluetoothStateExt;
import 'package:example/_features.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bluetoothStateAsync = ref.watch(bluetoothStateRef);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth'),
      ),
      body: bluetoothStateAsync.when<Widget>(
        data: (bluetoothState) => _ScanView(bluetoothState),
        error: (error, _) => ErrorView(
          label: error.toString(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

class _ScanView extends StatelessWidget {
  const _ScanView(this.bluetoothState);

  final BluetoothState bluetoothState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _Header(bluetoothState: bluetoothState),
        Expanded(
          child: bluetoothState.isOn
              ? const _DeviceList()
              : BluetoothStateLabel(bluetoothState: bluetoothState),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.bluetoothState});

  final BluetoothState bluetoothState;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final isOn = bluetoothState.isOn;

    return ColoredBox(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox.square(
            dimension: 130.0,
            child: Icon(
              isOn ? Icons.bluetooth : Icons.bluetooth_disabled,
              color: isOn ? Colors.green : Colors.red,
              size: 100.0,
            ),
          ),
          const Divider(indent: 16.0, endIndent: 16.0),
        ],
      ),
    );
  }
}

class _DeviceList extends ConsumerWidget {
  const _DeviceList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(devicesRef);

    return devices.when<Widget>(
      data: (devices) => ListView.builder(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        itemCount: devices.length,
        itemBuilder: (_, index) {
          final device = devices[index];
          return _DeviceListTile(
            device,
            padding: const EdgeInsets.only(top: 16.0),
          );
        },
      ),
      error: (error, _) => ErrorView(
        label: error.toString(),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class _DeviceListTile extends StatelessWidget {
  const _DeviceListTile(
    this.device, {
    this.padding,
  });

  final BluetoothDevice device;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final title = device.name.isNotEmpty ? device.name : '[Unknown device]';

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ListTile(
        tileColor: Colors.grey[200],
        title: Text(title),
        subtitle: Text(device.id),
        trailing: ElevatedButton(
          onPressed: () async => DevicePage.go<void>(context, device),
          child: const Text('Connect'),
        ),
      ),
    );
  }
}
