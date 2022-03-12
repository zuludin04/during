import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('Settings'),
      body: ListView(
        children: [
          const SizedBox(height: 5),
          _settingItem(
            'Saving',
            Icons.account_balance_wallet,
            () =>
                Get.toNamed(RoutePath.savingList, arguments: savingDetailType),
          ),
          const SizedBox(height: 15),
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
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 24),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right_outlined),
              ],
            ),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}
