import 'package:during/core/header_text.dart';
import 'package:during/core/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryPicker extends StatefulWidget {
  final String category;
  final String type;
  final Function(String selected) onSelectedCategory;

  CategoryPicker({
    required this.category,
    required this.type,
    required this.onSelectedCategory,
  });

  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: 'Category', isMore: false),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            var category = await Get.bottomSheet(_categoryList());
            widget.onSelectedCategory(category);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              widget.category,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryList() {
    var categories =
        widget.type == 'Income' ? incomeCategories : expenseCategories;
    return Container(
      color: Colors.white,
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.back(result: categories[index]);
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  iconAssetByCategory(categories[index]),
                  width: 30,
                  height: 30,
                ),
                Text(categories[index]),
              ],
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}
