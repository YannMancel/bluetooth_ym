import 'package:bluetooth_ym/bluetooth_ym.dart'
    show BluetoothDevice, BluetoothService;
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

class _ServiceListTile extends StatelessWidget {
  const _ServiceListTile(
    this.service, {
    this.margin,
  });

  final BluetoothService service;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: margin ?? EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('uuid: ${service.uuid}'),
          ],
        ),
      ),
    );
  }
}
