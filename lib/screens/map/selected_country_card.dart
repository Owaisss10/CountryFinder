import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/country_row_view.dart';
import 'package:country_finder/components/floating_panel.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:flutter/widgets.dart';

/// The selected pin's country, floating above the bottom of the map.
/// Tapping it opens the country's detail screen.
class SelectedCountryCard extends StatelessWidget {
  const SelectedCountryCard({
    super.key,
    required this.country,
    required this.onOpen,
  });

  final Country country;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onOpen,
        child: FloatingPanel(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.medium,
            vertical: Spacing.small,
          ),
          child: Row(
            children: [
              Expanded(child: CountryRowView(country: country)),
              AdaptiveIcon(
                AppIcon.chevronRight,
                size: ListRow.disclosureSize,
                color: AppColors.of(context).tertiaryLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
