import 'package:flutter/material.dart';

class ButtonChildWithLoading extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const ButtonChildWithLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(),
      );
    }

    return child;
  }
}
