import 'package:country_finder/core/constants.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AdaptiveButtonStyle { filled, plain }

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style = AdaptiveButtonStyle.plain,
  });

  final VoidCallback onPressed;
  final Widget child;
  final AdaptiveButtonStyle style;

  @override
  Widget build(BuildContext context) {
    if (context.isCupertino) {
      return switch (style) {
        AdaptiveButtonStyle.filled => CupertinoButton.filled(
          onPressed: onPressed,
          child: child,
        ),
        AdaptiveButtonStyle.plain => CupertinoButton(
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          child: child,
        ),
      };
    }
    return switch (style) {
      AdaptiveButtonStyle.filled => FilledButton(
        onPressed: onPressed,
        child: child,
      ),
      AdaptiveButtonStyle.plain => TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: child,
      ),
    };
  }
}
