import 'package:during/ui/dashboard/controllers/statistic_navigation_controller.dart';
import 'package:get/get.dart';

class StatisticNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticNavigationController());
  }
}
