import 'package:country_finder/theme/app_icons.dart';
import 'package:flutter/material.dart';

class AdaptiveIcon extends StatelessWidget {
  const AdaptiveIcon(this.icon, {super.key, this.size, this.color});

  final AppIcon icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      Icon(icon.of(context), size: size, color: color);
}
