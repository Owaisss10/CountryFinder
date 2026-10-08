import 'package:country_finder/core/constants.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A large-title bar as a sliver: CupertinoSliverNavigationBar on iOS,
/// SliverAppBar.large on Android.
class AdaptiveLargeTitleBar extends StatelessWidget {
  const AdaptiveLargeTitleBar({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    if (context.isCupertino) {
      return CupertinoSliverNavigationBar(
        backgroundColor: AppColors.of(context).bar,
        largeTitle: Text(title),
        trailing: trailing,
        // Each tab and pushed screen owns its bar; no hero transitions.
        transitionBetweenRoutes: false,
      );
    }
    return SliverAppBar.large(
      title: Text(title),
      actions: [
        ?trailing,
        const SizedBox(width: Spacing.small),
      ],
    );
  }
}
