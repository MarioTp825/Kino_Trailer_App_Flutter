import 'package:flutter/material.dart';

class BackHandler extends StatelessWidget {
  final Widget child;

  const BackHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pop(result);
        }
      },
      child: child,
    );
  }
}
