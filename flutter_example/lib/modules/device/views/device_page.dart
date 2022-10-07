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
                        onPressed: () {},
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
