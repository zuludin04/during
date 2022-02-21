import 'package:get/get.dart';

class SharePaymentController extends GetxController {
  var generated = false.obs;

  void generateQrCode() {
    generated.value = !generated.value;
  }
}
