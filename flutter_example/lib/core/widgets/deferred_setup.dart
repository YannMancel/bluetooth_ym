import 'package:example/_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RendererBinding;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget, WidgetRef;

typedef AsyncBuilder<T> = Future<T> Function(WidgetRef ref);

class DeferredSetup extends ConsumerStatefulWidget {
  const DeferredSetup({
    Key? key,
    required this.asyncBuilder,
  }) : super(key: key);

  final AsyncBuilder<Widget> asyncBuilder;

  @override
  ConsumerState<DeferredSetup> createState() => _DeferredSetupState();
}

class _DeferredSetupState extends ConsumerState<DeferredSetup> {
  late Future<Widget> _childAsync;

  @override
  void initState() {
    super.initState();
    RendererBinding.instance.deferFirstFrame();
    _childAsync = widget.asyncBuilder(ref)
      ..whenComplete(() => RendererBinding.instance.allowFirstFrame());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _childAsync,
      builder: (_, snapshot) {
        return snapshot.hasData
            ? snapshot.data!
            : snapshot.hasError
                ? const ErrorView()
                : const SizedBox.shrink();
      },
    );
  }
}
