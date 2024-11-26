import 'package:bloc_abstraction_example/src/common/extensions/platform_extension.dart';
import 'package:flutter/material.dart';

typedef OnPressedCallback = void Function();

class RefreshButtonWidget extends StatelessWidget {
  final OnPressedCallback onPressed;

  const RefreshButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return context.isWeb
        ? IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.refresh_outlined),
          )
        : const SizedBox.shrink();
  }
}
