import 'package:flutter/widgets.dart';

/// What a tab's title bar needs to host a search field. The screen owns the
/// controller and focus node, so the text survives the bar rebuilding the
/// field (as iOS does when a search starts).
class TitleBarSearch {
  const TitleBarSearch({
    required this.controller,
    required this.focusNode,
    required this.placeholder,
    required this.onChanged,
    required this.onCancel,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String placeholder;
  final ValueChanged<String> onChanged;

  /// Ends the search: clears the text and hides the keyboard.
  final VoidCallback onCancel;
}
