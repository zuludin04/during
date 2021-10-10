import 'package:during/core/utils/custom_theme.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/service/repository_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'During',
      theme: CustomTheme.defaultTheme,
      initialBinding: BindingsBuilder(() {
        Get.put(RepositoryService());
      }),
      getPages: AppPages.routes,
    );
  }
}
