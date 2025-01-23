import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/account_saving_item.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:during/ui/saving/controllers/saving_manage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingManageScreen extends StatefulWidget {
  const SavingManageScreen({super.key});

  @override
  State<SavingManageScreen> createState() => _SavingManageScreenState();
}

class _SavingManageScreenState extends State<SavingManageScreen> {
  final SavingManageController _controller = Get.find();
  final String type = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'saving'.tr,
        actions: [
          IconButton(
            onPressed: () async {
              var result =
                  await Get.toNamed(RoutePath.savingInsert, arguments: {
                'status': 'create',
              });
              if (result != null && result == 'OK') {
                _controller.loadSavings();
                Get.find<SavingController>().loadSavingList();
                Get.find<TransactionController>().loadSavingTotalBalance();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_controller.savings.isEmpty) {
                return EmptyLayout(message: 'empty_saving'.tr);
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) => AccountSavingItem(
                    onTap: () {
                      var saving = _controller.savings[index];
                      if (type == savingPickedType) {
                        Get.back(result: saving);
                      } else {
                        Get.toNamed(RoutePath.savingDetail,
                            arguments: saving.id);
                      }
                    },
                    saving: _controller.savings[index],
                    isCard: false,
                  ),
                  itemCount: _controller.savings.length,
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
