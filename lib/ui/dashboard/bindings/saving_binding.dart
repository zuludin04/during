import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:get/get.dart';

class SavingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingController());
  }
}
