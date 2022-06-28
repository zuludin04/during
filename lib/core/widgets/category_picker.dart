import 'package:during/core/widgets/category_item.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'header_text.dart';

class CategoryPicker extends StatelessWidget {
  final String title;
  final String dialogTitle;
  final String value;
  final List<CategoryEntity> categories;
  final Function(CategoryEntity selected) onSelectedCategory;

  const CategoryPicker({
    Key? key,
    required this.title,
    required this.dialogTitle,
    required this.value,
    required this.categories,
    required this.onSelectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: title, showTrailing: false),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            CategoryEntity? category = await Get.bottomSheet(_categoryList());
            if (category != null) {
              onSelectedCategory(category);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              value.toLowerCase().tr,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryList() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dialogTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return CategoryItem(
                  category: categories[index],
                  onTap: (category) {},
                );
                // return InkWell(
                //   onTap: () {
                //     Get.back(result: categories[index]);
                //   },
                //   child: Column(
                //     children: [
                //       Container(
                //         decoration: const BoxDecoration(
                //           color: Color(0xffffa400),
                //           shape: BoxShape.circle,
                //         ),
                //         padding: const EdgeInsets.all(12),
                //         child: SvgPicture.asset(
                //           'assets/category/${categories[index].icon}',
                //           color: const Color(0xff373a36),
                //           width: 30,
                //           height: 30,
                //         ),
                //       ),
                //       const SizedBox(height: 5),
                //       Text(
                //         categories[index].name ?? "",
                //         style: const TextStyle(fontSize: 15),
                //       ),
                //     ],
                //   ),
                // );
              },
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
