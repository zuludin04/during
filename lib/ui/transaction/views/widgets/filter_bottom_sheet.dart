import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/ui/transaction/controllers/transaction_filter_controller.dart';
import 'package:during/ui/transaction/views/widgets/chip_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  final TransactionFilterController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Container(
        height: size.height * 0.80,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            HeaderText(
              title: 'Filter',
              showTrailing: true,
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ChipCategories(
                    title: 'Range',
                    categories: dateRangeFilters,
                    selected: _controller.filtered.range!,
                    onSelected: _controller.changeFilterRange,
                  ),
                  SizedBox(height: 12),
                  ChipCategories(
                    title: 'Type',
                    categories: types,
                    selected: _controller.filtered.type!,
                    onSelected: _controller.changeFilterType,
                  ),
                  SizedBox(height: 12),
                  Obx(
                    () => ChipCategories(
                      title: 'Category',
                      categories: _controller.typed.value == 1
                          ? incomeCategories
                          : expenseCategories,
                      selected: _controller.filtered.category!,
                      onSelected: _controller.changeFilterCategory,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _controller.filterTransaction(),
                child: Text('Filter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
