import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:during/ui/transaction/views/widgets/chip_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  final TransactionNavigationController _controller = Get.find();

  FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            HeaderText(
              title: 'filter'.tr,
              showTrailing: true,
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  // ChipCategories(
                  //   title: 'range'.tr,
                  //   categories: dateRangeFilters,
                  //   multiChoice: false,
                  //   selected: _controller.filtered.range!,
                  //   onSelected: _controller.changeFilterRange,
                  // ),
                  // const SizedBox(height: 12),
                  ChipCategories(
                    title: 'type'.tr,
                    categories: types,
                    selected: _controller.filtered.type!,
                    onSelected: _controller.changeFilterType,
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => ChipCategories(
                      title: 'category'.tr,
                      categories: _controller.typed.value == 1
                          ? _controller.incomeCategories
                              .map((e) => e.name!)
                              .toList()
                          : _controller.expenseCategories
                              .map((e) => e.name!)
                              .toList(),
                      selected: _controller.filterCategory.value,
                      onSelected: _controller.changeFilterCategory,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _controller.filterTransaction(),
                child: Text(
                  'filter'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
