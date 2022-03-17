import 'package:during/core/widgets/toolbar_during.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageChangeScreen extends StatelessWidget {
  const LanguageChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('language'.tr),
      body: ListView(
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              Get.updateLocale(const Locale('en', 'US'));
            },
          ),
          ListTile(
            title: const Text('Bahasa Indonesia'),
            onTap: () {
              Get.updateLocale(const Locale('id', 'ID'));
            },
          ),
        ],
      ),
    );
  }
}
