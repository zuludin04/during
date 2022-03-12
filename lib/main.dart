import 'package:during/core/utils/custom_theme.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/service/repository_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();
  
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
        Get.put(CacheService());
      }),
      getPages: AppPages.routes,
    );
  }
}
