import 'package:during/core/constants.dart';
import 'package:during/core/helper.dart';
import 'package:during/core/string_extension.dart';
import 'package:during/core/toolbar_during.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/saving/controllers/saving_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavingListScreen extends StatelessWidget {
  final SavingListController _controller = Get.find();
  final String type = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('Savings'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed(RoutePath.SAVING_INSERT);
          if (result != null) {
            if (result == true) {
              _controller.loadSavings();
              Get.find<DashboardController>().loadSavingList();
            }
          }
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Obx(() {
          if (_controller.empty.value) {
            return Text('Saving is Empty');
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
    return GestureDetector(
      onTap: () {
        if (type == SAVING_PICKED_TYPE) {
          Get.back(result: saving);
        } else {
          Get.toNamed(RoutePath.SAVING_DETAIL, arguments: saving);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(int.parse('0x${saving.color}')),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconAssetByCategory(saving.category ?? 'Other'),
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  saving.name ?? '',
                  style: TextStyle(
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
