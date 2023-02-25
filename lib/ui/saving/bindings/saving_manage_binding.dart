import 'package:during/ui/saving/controllers/saving_manage_controller.dart';
import 'package:get/get.dart';

class SavingManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingManageController());
  }
}
