import 'package:during/ui/saving/controllers/saving_list_controller.dart';
import 'package:get/get.dart';

class SavingListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingListController());
  }
}
