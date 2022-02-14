import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/helper.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/saving/controllers/saving_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SavingNavigation extends StatelessWidget {
  final SavingListController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _dashboardAppBar(),
          Obx(() {
            if (_controller.empty.value) {
              return Text('Saving is Empty');
            } else {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      _savingItem(_controller.savings[index]),
                  itemCount: _controller.savings.length,
                ),
              );
            }
          })
        ],
      ),
    );
  }

  Widget _savingItem(SavingEntity saving) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutePath.SAVING_DETAIL, arguments: saving);
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

  Widget _dashboardAppBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xff373A36),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'ZM',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffFFA400),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              var result = await Get.toNamed(RoutePath.SAVING_INSERT);
              if (result != null) {
                if (result == true) {
                  _controller.loadSavings();
                  Get.find<DashboardController>().loadSavingList();
                }
              }
            },
            icon: Icon(
              Icons.add,
              color: Color(0xff373A36),
            ),
          ),
        ],
      ),
    );
  }
}
