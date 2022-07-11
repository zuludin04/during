import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'header_text.dart';

class ColorDialog extends StatefulWidget {
  final Function(Color color) selectedColor;
  final Color currentColor;

  const ColorDialog({
    Key? key,
    required this.selectedColor,
    this.currentColor = Colors.blue,
  }) : super(key: key);

  @override
  State<ColorDialog> createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  late Color color;

  @override
  void initState() {
    color = widget.currentColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: 'color'.tr, showTrailing: false),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            ColorPicker(
              color: color,
              onColorChanged: (Color color) {
                setState(() {
                  widget.selectedColor(color);
                  this.color = color;
                });
              },
              width: 44,
              height: 44,
              borderRadius: 22,
              heading: Text(
                'select_color'.tr,
                style: Theme.of(context).textTheme.headline5,
              ),
              subheading: Text(
                'select_shade'.tr,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ).showPickerDialog(
              context,
              constraints: const BoxConstraints(
                  minHeight: 480, minWidth: 300, maxWidth: 320),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  ColorTools.nameThatColor(color),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
