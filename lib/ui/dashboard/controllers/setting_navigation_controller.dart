import 'package:during/service/cache_service.dart';
import 'package:get/get.dart';

class SettingNavigationController extends GetxController {
  void toggleDarkTheme(bool theme) {
    CacheService.to.darkMode = theme;
  }
}
