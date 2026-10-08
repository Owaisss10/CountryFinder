import 'package:country_finder/core/constants.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/widgets.dart';

/// Shadows, built from [AppColors] and the tokens in core/constants.dart.
abstract final class AppShadows {
  /// The soft shadow under floating elements: the count chip, map controls
  /// and map markers.
  static BoxShadow floating(BuildContext context) => BoxShadow(
    color: AppColors.of(
      context,
    ).shadow.withValues(alpha: AppOpacity.chipShadow),
    blurRadius: ChipStyle.shadowBlur,
    offset: const Offset(0, ChipStyle.shadowOffsetY),
  );
}
