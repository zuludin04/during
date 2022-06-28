import 'package:during/data/source/entity/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;
  final Function(CategoryEntity category) onTap;

  const CategoryItem({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(category);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffffa400),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                'assets/category/${category.icon}',
                color: const Color(0xff373a36),
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              category.name ?? "",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
