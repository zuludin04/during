import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryTab extends StatefulWidget {
  final int type;

  const CategoryTab({Key? key, required this.type}) : super(key: key);

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab>
    with AutomaticKeepAliveClientMixin {
  final CategoryDashboardController _controller = Get.find();

  @override
  void initState() {
    _controller.loadCategory(widget.type);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<CategoryDashboardController>(
      id: widget.type,
      builder: (controller) {
        if (controller.loading) {
          return Center(child: Text('Category is Empty ${widget.type}'));
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) =>
                _categoryItem(controller.categories[index]),
            itemCount: controller.categories.length,
          );
        }
      },
    );
  }

  Widget _categoryItem(CategoryEntity category) {
    return Padding(
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
    );
  }
}
