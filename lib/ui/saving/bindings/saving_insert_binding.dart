import 'package:during/ui/saving/controllers/saving_insert_controller.dart';
import 'package:get/get.dart';

class SavingInsertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingInsertController());
  }
}
