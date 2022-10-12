import 'package:bluetooth_ym/bluetooth_ym.dart'
    show BluetoothCharacteristic, BluetoothDevice, BluetoothService;
import 'package:example/_features.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

class DevicePage extends ConsumerWidget {
  const DevicePage(this.device, {super.key});

  final BluetoothDevice device;

  static Future<T?> go<T>(
    BuildContext context,
    BluetoothDevice device,
  ) async {
    return Navigator.push<T>(
      context,
      MaterialPageRoute<T>(
        builder: (_) => DevicePage(device),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesRef(device));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device'),
      ),
      body: servicesAsync.when<Widget>(
        data: (services) => _ServiceList(services),
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

class _ServiceList extends StatelessWidget {
  const _ServiceList(this.services);

  final List<BluetoothService> services;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      itemBuilder: (_, index) {
        final service = services[index];
        return _ServiceListTile(
          service,
          margin: const EdgeInsets.only(top: 16.0),
        );
      },
      itemCount: services.length,
    );
  }
}

class _ServiceListTile extends ConsumerWidget {
  const _ServiceListTile(
    this.service, {
    this.margin,
  });

  final BluetoothService service;
  final EdgeInsetsGeometry? margin;

  void _notify(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  Future<List<int>> _readCharacteristic(
    WidgetRef ref, {
    required BluetoothCharacteristic characteristic,
  }) async {
    return ref.read(bluetoothRepositoryRef).readCharacteristics(characteristic);
  }

  Future<void> _writeCharacteristic(
    WidgetRef ref, {
    required BluetoothCharacteristic characteristic,
  }) async {
    //
    // + ----------- + ----------- + ----------- + ------------ + ------------ + ------------ + ------------ + ------------ +
    // |   Start +   |  High byte  |  Low byte   | Register bit | Register bit | Register bit | Register bit |     End      |
    // |   Control   |  of address |  of address |  bit[31:24]  |  bit[23:16]  |  bit[15:8]   |  bit[7:0]    |              |
    // + ----------- + ---- ------ + ----------- + ------------ + ------------ + ------------ + ------------ + ------------ +
    // | 8'b00110110 | 8'b00000000 |             |              |              |              |              | 8'b11001001  |
    // + ----------- + ----------- + ----------- + ------------ + ------------ + ------------ + ------------ + ------------ +
    // |     0x36    |    0x00     |             |              |              |              |              |     0xC9     |
    // + ----------- + ----------- + ----------- + ------------ + ------------ + ------------ + ------------ + ------------ +
    //
    final commandsOfSetupElectrode1 = <List<int>>[
      // Reset control
      <int>[0x36, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xC9],
      // Electrode pulse interval control: (take electrode 1 as an example)
      <int>[0x36, 0x00, 0x10, 0x00, 0x00, 0x27, 0x10, 0xC9],
      // Electrode pulse width control: (take electrode 1 as an example)
      <int>[0x36, 0x00, 0x11, 0x00, 0x00, 0x00, 0x64, 0xC9],
      // Electrode pulse amplitude control: (take electrode 1 as an example)
      <int>[0x36, 0x00, 0x12, 0x00, 0x00, 0x00, 0x32, 0xC9],
      // Electrode enable control: (take electrode 1 as an example)
      <int>[0x36, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0xC9],
      // Electrode turn-off control: (take electrode 1 as an example)
      <int>[0x36, 0x00, 0x03, 0x00, 0x00, 0x00, 0x10, 0xC9],
    ];

    final commandsOfVersionNumber = <List<int>>[
      // Reset control
      <int>[0x36, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xC9],
      // Version number
      <int>[0x36, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0xC9],
    ];

    for (final command in commandsOfSetupElectrode1) {
      await ref.read(bluetoothRepositoryRef).writeCharacteristics(
            characteristic,
            values: command,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const kGap = SizedBox.square(dimension: 16.0);
    const kDivider = Divider();
    const kTitleStyle = TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);

    return Card(
      color: Colors.grey[200],
      margin: margin ?? EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Service', style: kTitleStyle),
            kDivider,
            Text(service.uuid),
            kDivider,
            const Text('Characteristics', style: kTitleStyle),
            kDivider,
            ...service.characteristics.map<Widget>(
              (e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(e.uuid),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _readCharacteristic(
                            ref,
                            characteristic: e,
                          ).then((values) {
                            // TODO context.notify("...")
                            _notify(context, message: "READ:\n$values");
                          }, onError: (_, __) {
                            // TODO context.notify("...")
                            _notify(context, message: "Error");
                          });
                        },
                        child: const Text('Read'),
                      ),
                      kGap,
                      ElevatedButton(
                        onPressed: () {
                          _writeCharacteristic(ref, characteristic: e);
                        },
                        child: const Text('Write'),
                      ),
                    ],
                  ),
                  kGap,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
