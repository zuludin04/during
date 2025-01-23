import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:get/get.dart';

class SavingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingDetailController());
  }
}