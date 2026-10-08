import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/title_bar_search.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/l10n/gen/app_localizations.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:flutter/material.dart';

/// Android: a search bar under the large app bar. It scrolls away with the
/// list and comes back at the top, but stays pinned while a search is in
/// progress (text entered or the field focused).
class MaterialSearchHeader extends StatefulWidget {
  const MaterialSearchHeader({super.key, required this.search});

  final TitleBarSearch search;

  @override
  State<MaterialSearchHeader> createState() => _MaterialSearchHeaderState();
}

class _MaterialSearchHeaderState extends State<MaterialSearchHeader> {
  static const _height =
      SearchStyle.materialBarHeight + Spacing.xSmall + Spacing.small;

  bool get _searching =>
      widget.search.controller.text.isNotEmpty ||
      widget.search.focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    _listen(widget.search);
  }

  @override
  void didUpdateWidget(MaterialSearchHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.search.controller != widget.search.controller ||
        oldWidget.search.focusNode != widget.search.focusNode) {
      _unlisten(oldWidget.search);
      _listen(widget.search);
    }
  }

  @override
  void dispose() {
    _unlisten(widget.search);
    super.dispose();
  }

  void _listen(TitleBarSearch search) {
    search.controller.addListener(_onChange);
    search.focusNode.addListener(_onChange);
  }

  void _unlisten(TitleBarSearch search) {
    search.controller.removeListener(_onChange);
    search.focusNode.removeListener(_onChange);
  }

  void _onChange() => setState(() {});

  void _clear() {
    widget.search.controller.clear();
    widget.search.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final search = widget.search;
    final bar = Padding(
      padding: const EdgeInsets.fromLTRB(
        Spacing.large,
        Spacing.xSmall,
        Spacing.large,
        Spacing.small,
      ),
      child: SearchBar(
        controller: search.controller,
        focusNode: search.focusNode,
        hintText: search.placeholder,
        leading: const AdaptiveIcon(AppIcon.search),
        trailing: [
          if (search.controller.text.isNotEmpty)
            IconButton(
              tooltip: AppLocalizations.of(context).clearSearch,
              onPressed: _clear,
              icon: const AdaptiveIcon(AppIcon.clear),
            ),
        ],
        elevation: const WidgetStatePropertyAll(0),
        // Fixed height (Material's standard), and no minimum width, so it
        // fits narrow phones.
        constraints: const BoxConstraints(
          minHeight: SearchStyle.materialBarHeight,
          maxHeight: SearchStyle.materialBarHeight,
        ),
        onChanged: search.onChanged,
      ),
    );
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SearchHeaderDelegate(
        bar: bar,
        keepOpen: _searching,
        background: AppColors.of(context).background,
      ),
    );
  }
}

/// A header that collapses to nothing as the list scrolls (sliding the bar
/// up and out), unless [keepOpen] holds it at full height. Staying one
/// pinned header either way means the text field is never rebuilt, so it
/// keeps focus while typing.
class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SearchHeaderDelegate({
    required this.bar,
    required this.keepOpen,
    required this.background,
  });

  final Widget bar;
  final bool keepOpen;
  final Color background;

  @override
  double get maxExtent => _MaterialSearchHeaderState._height;

  @override
  double get minExtent => keepOpen ? maxExtent : 0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: background,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.bottomCenter,
          minHeight: maxExtent,
          maxHeight: maxExtent,
          child: bar,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SearchHeaderDelegate oldDelegate) =>
      oldDelegate.bar != bar ||
      oldDelegate.keepOpen != keepOpen ||
      oldDelegate.background != background;
}
