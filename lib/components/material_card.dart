import 'dart:ui';

import 'package:country_finder/core/constants.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// The translucent "thinMaterial" card: blurred on iOS, tonal on Android.
class MaterialCard extends StatelessWidget {
  const MaterialCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(CornerRadius.large);
    final content = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.of(context).material,
        borderRadius: radius,
      ),
      child: child,
    );
    if (!context.isCupertino) return content;
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: materialBlurSigma,
          sigmaY: materialBlurSigma,
        ),
        child: content,
      ),
    );
  }
}
