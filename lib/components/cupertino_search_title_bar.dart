import 'package:country_finder/components/title_bar_search.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

/// iOS: the large title with a search field underneath. The field scrolls
/// away with the list and comes back at the top. Tapping it starts a search:
/// the title collapses and the field stays pinned at the top, with Cancel,
/// until the search is cancelled.
class CupertinoSearchTitleBar extends StatefulWidget {
  const CupertinoSearchTitleBar({
    super.key,
    required this.title,
    required this.search,
    this.trailing,
  });

  final String title;
  final TitleBarSearch search;
  final Widget? trailing;

  @override
  State<CupertinoSearchTitleBar> createState() =>
      _CupertinoSearchTitleBarState();
}

class _CupertinoSearchTitleBarState extends State<CupertinoSearchTitleBar> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final search = widget.search;
    return CupertinoSliverNavigationBar.search(
      backgroundColor: AppColors.of(context).bar,
      largeTitle: Text(widget.title),
      trailing: widget.trailing,
      // Each tab and pushed screen owns its bar; no hero transitions.
      transitionBetweenRoutes: false,
      searchField: CupertinoSearchTextField(
        controller: search.controller,
        focusNode: search.focusNode,
        // The bar rebuilds the field when a search starts; focus it then.
        autofocus: _active,
        placeholder: search.placeholder,
        onChanged: search.onChanged,
      ),
      onSearchableBottomTap: (active) {
        setState(() => _active = active);
        if (!active) search.onCancel();
      },
    );
  }
}
