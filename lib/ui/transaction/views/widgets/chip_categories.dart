import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/data/model/filter_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChipCategories extends StatefulWidget {
  final String title;
  final List<String> categories;
  final bool multiChoice;
  final int selected;
  final Function(int id, String title, List<String> choices)? onSelected;

  const ChipCategories({
    Key? key,
    required this.title,
    required this.categories,
    required this.multiChoice,
    this.selected = 0,
    this.onSelected,
  }) : super(key: key);

  @override
  State<ChipCategories> createState() => _ChipCategoriesState();
}

class _ChipCategoriesState extends State<ChipCategories> {
  late int _idSelected;
  late List<String> _selectedChoices;

  @override
  void initState() {
    if (widget.multiChoice) {
      _selectedChoices = [];
    } else {
      _idSelected = widget.selected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(title: widget.title, showTrailing: false, titleSize: 14),
        const SizedBox(height: 5),
        Wrap(
          spacing: 8,
          children: chipsCategory(widget.categories)
              .map((e) => _chipItem(e))
              .toList(),
        ),
      ],
    );
  }

  Widget _chipItem(FilterChoice e) {
    return ChoiceChip(
      label: Text(
        e.title!.toLowerCase().tr,
        style: const TextStyle(color: Colors.white),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      selected: widget.multiChoice
          ? _selectedChoices.contains(e.title)
          : e.id == _idSelected,
      onSelected: (_) => setState(() {
        if (widget.multiChoice) {
          _selectedChoices.contains(e.title)
              ? _selectedChoices.remove(e.title)
              : _selectedChoices.add(e.title!);
        } else {
          _idSelected = e.id!;
        }
        List<String> choices = widget.multiChoice ? _selectedChoices : [];
        widget.onSelected!(e.id!, e.title!, choices);
      }),
      selectedColor: Colors.blue,
    );
  }
}
