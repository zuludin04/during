import 'package:flutter/material.dart';

extension ColorExtension on String {
  Color convertStringToColor() {
    return Color(int.parse('0xff$this'));
  }

  Color dynamicTextColor() {
    return convertStringToColor().computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
  }
}
