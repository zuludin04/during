import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:get/get.dart';

class TransactionFilterController extends GetxController {
  final DuringRepository _repository = Get.find();

  var savings = <SavingEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSavingList();
  }

  void loadSavingList() async {
    var result = await _repository.loadSaving();
    savings.value = result;
  }
}