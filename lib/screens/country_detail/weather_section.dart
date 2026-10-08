import 'package:country_finder/components/adaptive_button.dart';
import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/material_card.dart';
import 'package:country_finder/components/skeleton_box.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/weather.dart';
import 'package:country_finder/providers/country_detail_provider.dart';
import 'package:country_finder/screens/country_detail/section_heading.dart';
import 'package:country_finder/shared/country_formatter.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherSection extends ConsumerWidget {
  const WeatherSection({super.key, required this.alpha3Code});

  final String alpha3Code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final provider = countryDetailProvider(alpha3Code);
    final weatherState = ref.watch(provider.select((s) => s.weatherState));
    // Only built when the country resolved, see CountryDetailScreen.
    final country = ref.watch(provider.select((s) => s.country));
    final capital = country == null
        ? l10n.noCapital
        : CountryFormatter(l10n).capital(country);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.small,
      children: [
        SectionHeading(l10n.weatherIn(capital)),
        MaterialCard(
          padding: const EdgeInsets.all(Spacing.medium),
          child: switch (weatherState) {
            WeatherLoading() => const _WeatherSkeleton(),
            WeatherLoaded(:final weather) => _WeatherSuccess(weather: weather),
            WeatherFailed(:final error) => _WeatherError(
              message: error?.message(l10n) ?? l10n.noLocationForWeather,
              onRetry: ref.read(provider.notifier).retryWeather,
            ),
          },
        ),
      ],
    );
  }
}

/// Placeholder shapes while the weather loads.
class _WeatherSkeleton extends StatelessWidget {
  const _WeatherSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: Spacing.medium,
      children: [
        SkeletonBox(width: IconSize.weatherIcon, height: IconSize.weatherIcon),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Spacing.xxSmall,
          children: [
            SkeletonBox(
              width: SkeletonSize.primaryLineWidth,
              height: SkeletonSize.primaryLineHeight,
            ),
            SkeletonBox(
              width: SkeletonSize.secondaryLineWidth,
              height: SkeletonSize.secondaryLineHeight,
            ),
          ],
        ),
      ],
    );
  }
}

/// The current temperature and conditions.
class _WeatherSuccess extends StatelessWidget {
  const _WeatherSuccess({required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final formatter = CountryFormatter(AppLocalizations.of(context));
    final text = AppText.of(context);
    final colors = AppColors.of(context);
    return Row(
      spacing: Spacing.medium,
      children: [
        AdaptiveIcon(
          AppIcon.forWeather(weather.symbol),
          size: IconSize.weatherIcon,
          color: colors.system(SystemTint.orange),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatter.temperature(weather),
                style: text.title2.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                formatter.weatherDescription(weather.condition),
                style: text.subheadline.copyWith(color: colors.secondaryLabel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Why the weather couldn't be shown, with a retry button.
class _WeatherError extends StatelessWidget {
  const _WeatherError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final text = AppText.of(context);
    final colors = AppColors.of(context);
    return Row(
      spacing: Spacing.medium,
      children: [
        AdaptiveIcon(AppIcon.exclamationTriangle, color: colors.secondaryLabel),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: text.subheadline.copyWith(color: colors.secondaryLabel),
              ),
              AdaptiveButton(
                onPressed: onRetry,
                child: Text(
                  AppLocalizations.of(context).retry,
                  style: text.subheadline.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
