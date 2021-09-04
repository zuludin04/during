import 'package:during/core/header_text.dart';
import 'package:during/core/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryPicker extends StatefulWidget {
  final String title;
  final String dialogTitle;
  final String value;
  final List<String> categories;
  final Function(String selected) onSelectedCategory;

  CategoryPicker({
    required this.title,
    required this.dialogTitle,
    required this.value,
    required this.categories,
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
        HeaderText(title: widget.title, isMore: false),
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
              widget.value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.dialogTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.back(result: widget.categories[index]);
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffa400),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          iconAssetByCategory(widget.categories[index]),
                          color: Color(0xff373a36),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.categories[index],
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
