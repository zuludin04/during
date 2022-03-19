import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/constants.dart';
import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/saving/controllers/saving_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavingListScreen extends StatelessWidget {
  final SavingListController _controller = Get.find();
  final String type = Get.arguments;

  SavingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'saving'.tr,
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Get.toNamed(RoutePath.savingInsert);
              if (result != null) {
                if (result == true) {
                  _controller.loadSavings();
                  Get.find<HomeNavigationController>().loadSavingList();
                }
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          if (_controller.empty.value) {
            return EmptyLayout(message: 'empty_saving'.tr);
          } else {
            return ListView.builder(
              itemBuilder: (context, index) =>
                  _savingItem(_controller.savings[index]),
              itemCount: _controller.savings.length,
            );
          }
        }),
      ),
    );
  }

  Widget _savingItem(SavingEntity saving) {
    return InkWell(
      onTap: () {
        if (type == savingPickedType) {
          Get.back(result: saving);
        } else {
          Get.toNamed(RoutePath.savingDetail, arguments: saving);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(int.parse('0x${saving.color}')),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconAssetByCategory(saving.category ?? 'Other'),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  saving.name ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('Rp ${saving.balance!.toPriceFormat()}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
