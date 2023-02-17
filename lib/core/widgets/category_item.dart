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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(int.parse('0xff${category.color}')),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 2),
                  color: Colors.black26,
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/category/${category.icon}',
              colorFilter: ColorFilter.mode(
                Color(int.parse('0xff${category.color}')).computeLuminance() >
                        0.5
                    ? Colors.black
                    : Colors.white,
                BlendMode.srcIn,
              ),
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
    );
  }
}
