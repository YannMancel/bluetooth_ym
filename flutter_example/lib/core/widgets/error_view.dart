import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    this.label,
  }) : super(key: key);

  final String? label;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Center(
      child: Text(label ?? 'An error is found.'),
    );
  }
}
