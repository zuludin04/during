import 'package:during/core/header_text.dart';
import 'package:during/core/helper.dart';
import 'package:flutter/material.dart';

class ChipCategories extends StatefulWidget {
  final String title;
  final List<String> categories;

  ChipCategories(this.title, this.categories);

  @override
  _ChipCategoriesState createState() => _ChipCategoriesState();
}

class _ChipCategoriesState extends State<ChipCategories> {
  int _idSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(title: widget.title, showTrailing: false, titleSize: 14),
        Wrap(
          children: chipsCategory(widget.categories)
              .map((e) => ChoiceChip(
                    label: Text(e.title!),
                    selected: e.id == _idSelected,
                    onSelected: (_) => setState(
                      () => _idSelected = e.id!,
                    ),
                    selectedColor: Colors.red,
                  ))
              .toList(),
          spacing: 8,
        ),
      ],
    );
  }
}
