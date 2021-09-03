import 'package:during/core/header_text.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorDialog extends StatefulWidget {
  final Function(Color color) selectedColor;

  ColorDialog(this.selectedColor);

  @override
  _ColorDialogState createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: 'Color', isMore: false),
        SizedBox(height: 8),
        GestureDetector(
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
                'Select color',
                style: Theme.of(context).textTheme.headline5,
              ),
              subheading: Text(
                'Select color shade',
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                SizedBox(width: 10),
                Text(
                  ColorTools.nameThatColor(color),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
