import 'package:country_finder/core/constants.dart';
import 'package:country_finder/shared/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveProgress extends StatelessWidget {
  const AdaptiveProgress({super.key, this.small = false});

  final bool small;

  @override
  Widget build(BuildContext context) {
    if (context.isCupertino) {
      final diameter = small ? ProgressSize.small : ProgressSize.regular;
      return CupertinoActivityIndicator(radius: diameter / 2);
    }
    return SizedBox.square(
      dimension: small ? ProgressSize.small : ProgressSize.regularMaterial,
      child: CircularProgressIndicator(
        strokeWidth: small
            ? ProgressSize.smallStroke
            : ProgressSize.regularStroke,
      ),
    );
  }
}
