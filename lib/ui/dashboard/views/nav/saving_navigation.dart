import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/helper.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SavingNavigation extends StatelessWidget {
  final HomeNavigationController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.emptySaving.value) {
        return Center(
          child: Text('Saving is Empty'),
        );
      } else {
        return ListView.builder(
          itemBuilder: (context, index) =>
              _savingItem(_controller.savings[index]),
          itemCount: _controller.savings.length,
        );
      }
    });
  }

  Widget _savingItem(SavingEntity saving) {
    return InkWell(
      onTap: () async {
        var result =
            await Get.toNamed(RoutePath.savingDetail, arguments: saving);
        if (result != null) {
          if (result == true) {
            _controller.loadSavingList();
          }
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
