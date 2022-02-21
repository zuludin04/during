import 'package:during/ui/share/controllers/share_payment_controller.dart';
import 'package:get/get.dart';

class SharePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SharePaymentController());
  }
}
