import 'package:during/data/during_repository.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:get/get.dart';

class TransactionFilterController extends GetxController {
  final DuringRepository _repository = Get.find();

  var savings = <SavingEntity>[].obs;
  var emptySaving = false.obs;

  FilterTransaction filtered = FilterTransaction(
    range: 1,
    type: 0,
    category: 0,
  );

  var filterRange = 1;
  var filterType = 0;
  var typed = 0.obs;
  var filterCategory = 0;

  @override
  void onInit() {
    super.onInit();
    loadSavingList();
  }

  void loadSavingList() async {
    var result = await _repository.loadSaving();
    emptySaving.value = result.isEmpty;
    if (result.isNotEmpty) savings.value = result;
  }

  void filterTransaction() {
    FilterTransaction filter = FilterTransaction(
      range: filterRange,
      type: filterType,
      category: filterCategory,
    );
    filtered = filter;

    Get.back(result: filtered);
  }

  void changeFilterRange(int range) {
    filterRange = range;
  }

  void changeFilterType(int type) {
    filterType = type;
    typed.value = type;
  }

  void changeFilterCategory(int category) {
    filterCategory = category;
  }
}
