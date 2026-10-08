import 'package:country_finder/core/constants.dart';
import 'package:country_finder/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// A rounded placeholder block that pulses while content loads. The pulse
/// is skipped when the system asks for reduced motion.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppAnimation.skeletonPulse,
  );
  late final Animation<double> _opacity = Tween<double>(
    begin: 1,
    end: AppOpacity.skeletonPulseLow,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      _controller.value = 0;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.of(context).separator,
          borderRadius: BorderRadius.circular(CornerRadius.small),
        ),
      ),
    );
  }
}
