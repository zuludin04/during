import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:get/get.dart';

class CategoryDashboardController extends GetxController {
  final DuringRepository _repository = Get.find();

  var loading = false;
  var expenseCategory = <CategoryEntity>[];
  var incomeCategory = <CategoryEntity>[];
  var savingCategory = <CategoryEntity>[];

  @override
  void onInit() {
    loadCategory();
    super.onInit();
  }

  void loadCategory() async {
    loading = true;

    var category = await _repository.loadCategories();
    expenseCategory = category.where((element) => element.type == 3).toList();
    incomeCategory = category.where((element) => element.type == 2).toList();
    savingCategory = category.where((element) => element.type == 1).toList();

    loading = false;
    update();
  }
}
