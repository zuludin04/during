import 'package:during/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'header_text.dart';

class CategoryPicker extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: title, showTrailing: false),
        SizedBox(height: 8),
        InkWell(
          onTap: () async {
            String? category = await Get.bottomSheet(_categoryList());
            if (category != null) {
              onSelectedCategory(category);
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              value,
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
            dialogTitle,
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
                return InkWell(
                  onTap: () {
                    Get.back(result: categories[index]);
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
                          iconAssetByCategory(categories[index]),
                          color: Color(0xff373a36),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        categories[index],
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                );
              },
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
