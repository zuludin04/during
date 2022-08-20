import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:during/ui/dashboard/views/widgets/date_selector.dart';
import 'package:during/ui/transaction/views/widgets/chip_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TransactionNavigationController _controller = Get.find();

  bool showDateRange = false;

  @override
  void initState() {
    if (_controller.filtered.range == 4) showDateRange = true;
    super.initState();
  }

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
              trailing: TextButton(
                onPressed: _controller.resetFilter,
                child: Text(
                  'reset'.tr,
                  style: TextStyle(color: Get.theme.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  HeaderText(
                    title: 'range'.tr,
                    showTrailing: false,
                    titleSize: 14,
                  ),
                  const SizedBox(height: 8),
                  ChipCategories(
                    title: '',
                    categories: dateRangeFilters,
                    selected: _controller.filtered.range!,
                    onSelected: (id, title) {
                      _controller.changeFilterRange(id, title);
                      setState(() {
                        if (title == 'Custom') {
                          showDateRange = true;
                        } else {
                          showDateRange = false;
                        }
                      });
                    },
                  ),
                  Visibility(
                    visible: showDateRange,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('start'.tr),
                              const SizedBox(height: 4),
                              DateSelector(
                                selectedDate: (date) {
                                  _controller.startDate = date;
                                },
                                currentDate: DateTime.now(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('end'.tr),
                              const SizedBox(height: 4),
                              DateSelector(
                                selectedDate: (date) {
                                  _controller.endDate = date;
                                },
                                currentDate: DateTime.now(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ChipCategories(
                    title: 'type'.tr,
                    categories: types,
                    selected: _controller.filtered.type!,
                    onSelected: _controller.changeFilterType,
                  ),
                  const SizedBox(height: 24),
                  ChipCategories(
                    title: 'saving'.tr,
                    categories:
                        _controller.savings.map((e) => e.name!).toList(),
                    selected: _controller.filtered.saving!,
                    onSelected: _controller.changeFilterSaving,
                  ),
                  const SizedBox(height: 24),
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
                      selected: _controller.filtered.category!,
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
