import 'package:during/core/widgets/category_item.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CategoryDashboardScreen extends StatelessWidget {
  const CategoryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'category'.tr,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(
                RoutePath.categoryCreate,
                arguments: {
                  'update': false,
                  'source': 'category',
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          GetBuilder<CategoryDashboardController>(
            builder: (controller) {
              if (controller.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: CustomScrollView(
                    slivers: [
                      _categoryTypes(
                          context, 'saving'.tr, controller.savingCategory),
                      _categoryTypes(
                          context, 'income'.tr, controller.incomeCategory),
                      _categoryTypes(
                          context, 'expense'.tr, controller.expenseCategory),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _categoryTypes(
      BuildContext context, title, List<CategoryEntity> categories) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        if (categories.isEmpty)
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              alignment: Alignment.center,
              child: EmptyLayout(message: 'category_empty'.tr),
            ),
          ),
        if (categories.isNotEmpty)
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CategoryItem(
                  category: categories[index],
                  onTap: (category) {
                    Get.toNamed(RoutePath.categoryCreate, arguments: {
                      'category': categories[index],
                      'update': true,
                      'source': 'category',
                    });
                  },
                );
              },
              childCount: categories.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1.1,
            ),
          ),
      ],
    );
  }
}
