import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/account_saving_item.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingNavigation extends StatefulWidget {
  const SavingNavigation({super.key});

  @override
  State<SavingNavigation> createState() => _SavingNavigationState();
}

class _SavingNavigationState extends State<SavingNavigation> {
  final SavingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Obx(
          () => SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var saving = _controller.savings[index];
                  if (saving.name == emptySavingHash) {
                    return _SavingEmptyItem(
                      onTap: () async {
                        var result = await Get.toNamed(RoutePath.savingInsert,
                            arguments: {'status': 'create'});
                        if (result != null && result == 'OK') {
                          Get.find<TransactionController>()
                              .loadSavingTotalBalance();
                          _controller.loadSavingList();
                        }
                      },
                    );
                  } else {
                    return AccountSavingItem(
                      onTap: () => Get.toNamed(RoutePath.savingDetail,
                          arguments: saving.id),
                      saving: saving,
                      isCard: true,
                    );
                  }
                },
                childCount: _controller.savings.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SavingEmptyItem extends StatelessWidget {
  final Function() onTap;

  const _SavingEmptyItem({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
        ),
        padding: const EdgeInsets.all(12),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
