import 'package:during/data/during_repository.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:get/get.dart';

class TransactionFilterController extends GetxController {
  final DuringRepository _repository = Get.find();

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
