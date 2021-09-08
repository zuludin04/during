import 'package:during/core/header_text.dart';
import 'package:during/core/helper.dart';
import 'package:during/ui/transaction/views/widgets/chip_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
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
                  ChipCategories('Range', dateRangeFilters),
                  SizedBox(height: 12),
                  ChipCategories('Type', types),
                  SizedBox(height: 12),
                  ChipCategories('Category', expenseCategories),
                  SizedBox(height: 12),
                  ChipCategories('Saving', ['BCA', 'BSI']),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: Text('Filter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
