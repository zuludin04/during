import 'package:during/core/utils/custom_theme.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/service/language_service.dart';
import 'package:during/service/repository_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();

  @override
  void initState() {
    bool darkMode = storage.read('DARK_MODE') ?? false;
    Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'During',
      theme: CustomTheme.defaultTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: BindingsBuilder(() {
        Get.put(RepositoryService());
        Get.put(CacheService());
      }),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      translations: LanguageService(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
