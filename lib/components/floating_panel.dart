import 'package:country_finder/core/constants.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_shadows.dart';
import 'package:flutter/widgets.dart';

/// A rounded panel floating over content such as the map: the bar
/// background with the floating shadow.
class FloatingPanel extends StatelessWidget {
  const FloatingPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Spacing.small),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.of(context).bar,
        borderRadius: BorderRadius.circular(CornerRadius.large),
        boxShadow: [AppShadows.floating(context)],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
