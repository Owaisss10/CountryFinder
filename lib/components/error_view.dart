import 'package:country_finder/components/adaptive_button.dart';
import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = AppText.of(context);
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Spacing.large,
          children: [
            AdaptiveIcon(
              AppIcon.exclamationTriangle,
              size: IconSize.stateIcon,
              color: colors.secondaryLabel,
            ),
            Text(l10n.somethingWentWrong, style: text.headline),
            Text(
              message,
              textAlign: TextAlign.center,
              style: text.subheadline.copyWith(color: colors.secondaryLabel),
            ),
            AdaptiveButton(
              style: AdaptiveButtonStyle.filled,
              onPressed: onRetry,
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
