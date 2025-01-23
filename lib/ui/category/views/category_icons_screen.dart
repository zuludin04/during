import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryIconsScreen extends StatelessWidget {
  final String color = Get.arguments['color'];
  final String icon = Get.arguments['icon'];

  CategoryIconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('category_icon'.tr),
      body: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.25,
        children: categories.map((e) => _category(e)).toList(),
      ),
    );
  }

  Widget _category(String path) {
    return InkWell(
      onTap: () {
        Get.back(result: path);
      },
      child: Container(
        decoration: BoxDecoration(
          color: icon == path
              ? Color(int.parse('0xff$color'))
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          'assets/category/$path',
          colorFilter: ColorFilter.mode(
            icon == path ? Colors.white : const Color(0xff373a36),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
