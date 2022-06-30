import 'package:during/ui/category/controllers/category_create_controller.dart';
import 'package:get/get.dart';

class CategoryCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryCreateController());
  }
}
