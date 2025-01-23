import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:get/get.dart';

class CategoryDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDashboardController());
  }
}
