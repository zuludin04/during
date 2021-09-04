import 'package:during/core/helper.dart';
import 'package:during/core/string_extension.dart';
import 'package:during/core/toolbar_during.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/saving/controllers/saving_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavingListScreen extends StatelessWidget {
  final SavingListController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('Savings'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed(RoutePath.SAVING_INSERT);
          if (result != null) {
            if (result == true) _controller.loadSavings();
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
        Get.back(result: saving);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Color(int.parse('0x${saving.color}')),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                  iconAssetByCategory(saving.category ?? 'Other')),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(saving.name ?? ''),
                Text('Rp ${saving.balance!.toPriceFormat()}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
