import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:flutter/material.dart';

class ChipCategories extends StatefulWidget {
  final String title;
  final List<String> categories;
  final int selected;
  final Function(int id)? onSelected;

  ChipCategories({
    required this.title,
    required this.categories,
    this.selected = 0,
    this.onSelected,
  });

  @override
  _ChipCategoriesState createState() => _ChipCategoriesState();
}

class _ChipCategoriesState extends State<ChipCategories> {
  late int _idSelected;

  @override
  void initState() {
    _idSelected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(title: widget.title, showTrailing: false, titleSize: 14),
        SizedBox(height: 5),
        Wrap(
          children: chipsCategory(widget.categories)
              .map((e) => ChoiceChip(
                    label: Text(
                      e.title!,
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    selected: e.id == _idSelected,
                    onSelected: (_) => setState(() {
                      _idSelected = e.id!;
                      widget.onSelected!(e.id!);
                    }),
                    selectedColor: Color(0xffFFA400),
                  ))
              .toList(),
          spacing: 8,
        ),
      ],
    );
  }
}
