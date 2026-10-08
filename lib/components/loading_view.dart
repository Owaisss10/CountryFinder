import 'package:country_finder/components/adaptive_progress.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Spacing.medium,
        children: [
          const AdaptiveProgress(),
          Text(
            message,
            style: AppText.of(
              context,
            ).subheadline.copyWith(color: AppColors.of(context).secondaryLabel),
          ),
        ],
      ),
    );
  }
}
