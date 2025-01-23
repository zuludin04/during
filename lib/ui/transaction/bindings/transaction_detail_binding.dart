import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/transaction/controllers/transaction_detail_controller.dart';
import 'package:get/get.dart';

class TransactionDetailBinding extends Bindings {
  @override
  void dependencies() {
    TransactionEntity transaction = Get.arguments;
    String source = Get.parameters['source']!;
    Get.lazyPut(() => TransactionDetailController(transaction, source));
  }
}
