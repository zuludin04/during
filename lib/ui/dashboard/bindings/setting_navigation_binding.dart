import 'package:during/ui/dashboard/controllers/setting_navigation_controller.dart';
import 'package:get/get.dart';

class SettingNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingNavigationController());
  }
}
