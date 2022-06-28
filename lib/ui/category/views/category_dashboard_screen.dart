import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/category/views/widgets/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDashboardScreen extends StatelessWidget {
  const CategoryDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: ToolbarDuring.defaultToolbar(
          'category'.tr,
          tabs: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'income'.tr),
              Tab(text: 'expense'.tr),
              Tab(text: 'saving'.tr),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(RoutePath.categoryCreate),
          child: const Icon(Icons.add),
        ),
        body: const TabBarView(
          children: [
            CategoryTab(type: 2),
            CategoryTab(type: 3),
            CategoryTab(type: 1),
          ],
        ),
      ),
    );
  }
}
