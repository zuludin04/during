import 'package:during/core/widgets/category_item.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/routes/app_pages.dart';
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
    super.key,
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
              value,
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
          _categoryIcons(),
        ],
      ),
    );
  }

  Widget _categoryIcons() {
    if (categories.isEmpty) {
      return Column(
        children: [
          Container(
            height: 150,
            alignment: Alignment.center,
            child: EmptyLayout(message: 'category_empty'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.toNamed(RoutePath.categoryCreate, arguments: {
                'update': false,
                'source': dialogTitle,
              });
            },
            child: Text('create'.tr),
          ),
        ],
      );
    } else {
      return Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return CategoryItem(
              category: categories[index],
              onTap: (category) {
                Get.back(result: category);
              },
            );
          },
          itemCount: categories.length,
        ),
      );
    }
  }
}
