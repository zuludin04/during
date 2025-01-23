import 'package:during/ui/transfer/controllers/transfer_controller.dart';
import 'package:get/get.dart';

class TransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransferController());
  }
}
