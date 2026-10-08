import 'package:country_finder/components/view_mode_toggle.dart';
import 'package:country_finder/core/app_tab.dart';
import 'package:country_finder/models/country.dart';
import 'package:country_finder/screens/map/map_screen.dart';
import 'package:flutter/material.dart';

/// A tab's list, or the same countries on the map, with a floating button
/// to switch between them. Both views stay alive once shown, so the list
/// keeps its scroll position and the map its camera.
class ListMapSwitcher extends StatefulWidget {
  const ListMapSwitcher({
    super.key,
    required this.tab,
    required this.countries,
    required this.list,
  });

  final AppTab tab;

  /// What the map pins: the countries the list is showing.
  final List<Country> countries;
  final Widget list;

  @override
  State<ListMapSwitcher> createState() => _ListMapSwitcherState();
}

class _ListMapSwitcherState extends State<ListMapSwitcher> {
  bool _showingMap = false;

  // The map is only built once first opened, then kept.
  bool _mapBuilt = false;

  void _toggle() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showingMap = !_showingMap;
      _mapBuilt = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IndexedStack(
            index: _showingMap ? 1 : 0,
            children: [
              widget.list,
              if (_mapBuilt)
                MapScreen(
                  tab: widget.tab,
                  countries: widget.countries,
                  bottomInset: ViewModeToggle.reservedHeight(context),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(
            child: ViewModeToggle(showingMap: _showingMap, onPressed: _toggle),
          ),
        ),
      ],
    );
  }
}
