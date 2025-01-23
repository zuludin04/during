import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:get/get.dart';

class TransactionCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionCreateController());
  }
}
