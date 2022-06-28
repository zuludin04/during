import 'package:during/core/widgets/category_item.dart';
import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:flutter/material.dart';
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
            itemBuilder: (context, index) => CategoryItem(
              category: controller.categories[index],
              onTap: (category) {},
            ),
            itemCount: controller.categories.length,
          );
        }
      },
    );
  }
}
