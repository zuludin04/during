import 'package:during/ui/dashboard/controllers/statistic_controller.dart';
import 'package:get/get.dart';

class StatisticBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticController());
  }
}
