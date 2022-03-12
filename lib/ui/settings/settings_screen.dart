import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('Settings'),
      body: ListView(
        children: [
          SizedBox(height: 5),
          _settingItem(
            'Saving',
            Icons.account_balance_wallet,
            () => Get.toNamed(RoutePath.SAVING_LIST,
                arguments: savingDetailType),
          ),
          SizedBox(height: 15),
          _settingItem(
            'Rating',
            Icons.star,
            () {},
          ),
          _settingItem(
            'Share',
            Icons.share,
            () {},
          ),
          _settingItem(
            'Info',
            Icons.info,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _settingItem(String title, IconData icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 24),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_outlined),
              ],
            ),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}
