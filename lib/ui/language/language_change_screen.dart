import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/service/cache_service.dart';
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
              CacheService.to.selectedLanguage = 'en_US';
              Get.updateLocale(const Locale('en', 'US'));
            },
          ),
          ListTile(
            title: const Text('Bahasa Indonesia'),
            onTap: () {
              CacheService.to.selectedLanguage = 'id_ID';
              Get.updateLocale(const Locale('id', 'ID'));
            },
          ),
        ],
      ),
    );
  }
}
