import 'package:during/core/utils/base_controller.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:get/get.dart';

class SavingManageController extends BaseController {
  var savings = <SavingEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSavings();
  }

  Future<void> loadSavings() async {
    var result = await repository.loadSaving();
    savings.value = result;
  }
}
