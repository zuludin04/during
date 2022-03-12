import 'package:get/get.dart';

class SharePaymentController extends GetxController {
  var generated = false.obs;

  var paymentName = ''.obs;
  var paymentNominal = '0'.obs;

  void generateQrCode() {
    generated.value = !generated.value;
  }
}
