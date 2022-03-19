import 'package:during/service/cache_service.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:get/get.dart';

class SettingNavigationController extends GetxController {
  void toggleSavingSlider(bool slider) {
    CacheService.to.hideSlider = slider;
    Get.find<HomeNavigationController>().hideSlider.value = slider;
  }

  void toggleDarkTheme(bool theme) {
    CacheService.to.darkMode = theme;
  }
}
