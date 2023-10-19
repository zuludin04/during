import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryIconsScreen extends StatelessWidget {
  const CategoryIconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('category_icon'.tr),
      body: GridView.count(
        crossAxisCount: 4,
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
        decoration: const BoxDecoration(
          color: Color(0xffffa400),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 2),
              color: Colors.black26,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          'assets/category/$path',
          colorFilter:
              const ColorFilter.mode(Color(0xff373a36), BlendMode.srcIn),
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
