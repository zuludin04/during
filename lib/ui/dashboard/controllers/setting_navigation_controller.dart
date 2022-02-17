import 'package:during/service/cache_service.dart';
import 'package:get/get.dart';

class SettingNavigationController extends GetxController {
  void toggleSavingSlider(bool slider) {
    CacheService.to.showSlider = slider;
  }
}
