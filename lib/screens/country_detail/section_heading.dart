import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_text.dart';
import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppText.of(context).caption.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.of(context).secondaryLabel,
      ),
    );
  }
}
