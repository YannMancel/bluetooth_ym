import 'package:bluetooth_ym/bluetooth_ym.dart'
    show
        BluetoothDevice,
        BluetoothRepositoryInterface,
        BluetoothService,
        BluetoothState,
        BluetoothYM;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show FutureProvider, Provider, StreamProvider;

final bluetoothRepositoryRef = Provider<BluetoothRepositoryInterface>(
  (_) => BluetoothYM.instance(isDebugMode: true),
  name: 'bluetoothRepositoryRef',
);

final bluetoothStateRef = StreamProvider.autoDispose<BluetoothState>(
  (ref) => ref.watch(bluetoothRepositoryRef).state,
  name: 'bluetoothStateRef',
);

final devicesRef = FutureProvider.autoDispose<List<BluetoothDevice>>(
  (ref) async => ref.watch(bluetoothRepositoryRef).startScan(),
  name: 'devicesRef',
);

final servicesRef =
    FutureProvider.autoDispose.family<List<BluetoothService>, BluetoothDevice>(
  (ref, device) async {
    final repository = ref.watch(bluetoothRepositoryRef);
    await repository.connect(device);
    final services = await repository.getServices(device);

    ref.onDispose(() async => repository.disconnect(device));

    return services;
  },
  name: 'servicesRef',
);
