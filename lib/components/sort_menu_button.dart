import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/models/sort_option.dart';
import 'package:country_finder/providers/countries_list_provider.dart';
import 'package:country_finder/shared/country_formatter.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App-bar sort control: an icon-only button whose label ("Sort: Name") is
/// read by screen readers and shown as the Android tooltip. In the menu, the
/// active field shows the current direction.
class SortMenuButton extends ConsumerWidget {
  const SortMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortOption = ref.watch(
      countriesListProvider.select((s) => s.sortOption),
    );
    void select(SortField field) =>
        ref.read(countriesListProvider.notifier).selectSortField(field);
    return context.isCupertino
        ? _CupertinoSortButton(sortOption: sortOption, onSelect: select)
        : _MaterialSortMenu(sortOption: sortOption, onSelect: select);
  }
}

/// "Sort: Name", for screen readers and the Android tooltip.
String _label(BuildContext context, SortOption sortOption) {
  final l10n = AppLocalizations.of(context);
  return l10n.sortLabel(
    CountryFormatter(l10n).sortFieldTitle(sortOption.field),
  );
}

/// The direction arrow shown next to the active field, or null.
AppIcon? _directionIcon(SortOption sortOption, SortField field) =>
    field != sortOption.field
    ? null
    : sortOption.direction == SortDirection.ascending
    ? AppIcon.chevronUp
    : AppIcon.chevronDown;

/// iOS: an icon button that opens an action sheet.
class _CupertinoSortButton extends StatelessWidget {
  const _CupertinoSortButton({
    required this.sortOption,
    required this.onSelect,
  });

  final SortOption sortOption;
  final ValueChanged<SortField> onSelect;

  @override
  Widget build(BuildContext context) {
    final formatter = CountryFormatter(AppLocalizations.of(context));
    return Semantics(
      button: true,
      label: _label(context, sortOption),
      excludeSemantics: true,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => showCupertinoModalPopup<void>(
          context: context,
          builder: (popupContext) => CupertinoActionSheet(
            actions: [
              for (final field in SortField.values)
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(popupContext).pop();
                    onSelect(field);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: Spacing.small,
                    children: [
                      Text(formatter.sortFieldTitle(field)),
                      if (_directionIcon(sortOption, field) case final icon?)
                        AdaptiveIcon(
                          icon,
                          size: IconSize.sortDirection,
                          // Matches the action's label, which uses the theme
                          // color.
                          color: AppColors.of(popupContext).accent,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        child: AdaptiveIcon(AppIcon.sort, color: AppColors.of(context).accent),
      ),
    );
  }
}

/// Android: an icon button with a popup menu.
class _MaterialSortMenu extends StatelessWidget {
  const _MaterialSortMenu({required this.sortOption, required this.onSelect});

  final SortOption sortOption;
  final ValueChanged<SortField> onSelect;

  @override
  Widget build(BuildContext context) {
    final formatter = CountryFormatter(AppLocalizations.of(context));
    return PopupMenuButton<SortField>(
      tooltip: _label(context, sortOption),
      onSelected: onSelect,
      itemBuilder: (_) => [
        for (final field in SortField.values)
          PopupMenuItem(
            value: field,
            child: Row(
              children: [
                Expanded(child: Text(formatter.sortFieldTitle(field))),
                if (_directionIcon(sortOption, field) case final icon?)
                  AdaptiveIcon(icon, size: IconSize.sortDirection),
              ],
            ),
          ),
      ],
      icon: AdaptiveIcon(AppIcon.sort, color: AppColors.of(context).accent),
    );
  }
}
