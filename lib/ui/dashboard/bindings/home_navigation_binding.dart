import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:get/get.dart';

class HomeNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeNavigationController());
  }
}