import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:get/get.dart';

class TransactionNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionNavigationController());
  }
}
