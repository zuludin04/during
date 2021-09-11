import 'package:during/ui/transaction/controllers/transaction_filter_controller.dart';
import 'package:get/get.dart';

class TransactionFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionFilterController());
  }
}
