import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_finder/components/adaptive_icon.dart';
import 'package:country_finder/components/adaptive_progress.dart';
import 'package:country_finder/core/constants.dart';
import 'package:country_finder/providers/dependency_providers.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:country_finder/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A country's flag: the PNG, falling back to the SVG if the PNG is missing
/// or broken, then to a placeholder. Both are cached on the device, so flags
/// seen once still show offline.
class FlagImage extends ConsumerWidget {
  const FlagImage({
    super.key,
    required this.url,
    this.svgUrl,
    this.width = IconSize.flagWidth,
    this.height = IconSize.flagHeight,
  });

  final Uri? url;
  final Uri? svgUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final url = this.url;
    final svgUrl = this.svgUrl;
    final cacheManager = ref.watch(flagCacheManagerProvider);
    final iconSize = height * IconSize.flagPlaceholderScale;

    Widget placeholder(AppIcon icon, {bool loading = false}) => ColoredBox(
      color: colors.secondaryBackground,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AdaptiveIcon(icon, size: iconSize, color: colors.tertiaryLabel),
          if (loading) const AdaptiveProgress(small: true),
        ],
      ),
    );

    Widget svgFallback() => svgUrl == null
        ? placeholder(AppIcon.flagSlash)
        : FutureBuilder<File>(
            future: cacheManager.getSingleFile(svgUrl.toString()),
            builder: (context, snapshot) => switch (snapshot) {
              AsyncSnapshot(:final data?) => SvgPicture.file(
                data,
                fit: BoxFit.cover,
                width: width,
                height: height,
                errorBuilder: (_, _, _) => placeholder(AppIcon.flagSlash),
              ),
              AsyncSnapshot(hasError: true) => placeholder(AppIcon.flagSlash),
              _ => placeholder(AppIcon.photo, loading: true),
            },
          );

    return Container(
      width: width,
      height: height,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CornerRadius.small),
        border: Border.all(
          color: colors.separator,
          width: StrokeWidth.hairline,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CornerRadius.small),
        child: url == null
            ? svgFallback()
            : CachedNetworkImage(
                imageUrl: url.toString(),
                cacheManager: cacheManager,
                fit: BoxFit.cover,
                width: width,
                height: height,
                fadeInDuration: Duration.zero,
                placeholder: (_, _) =>
                    placeholder(AppIcon.photo, loading: true),
                errorWidget: (_, _, _) => svgFallback(),
              ),
      ),
    );
  }
}
