import 'package:during/core/utils/base_controller.dart';
import 'package:during/data/source/entity/category_entity.dart';

class CategoryDashboardController extends BaseController {
  var loading = false;
  var expenseCategory = <CategoryEntity>[];
  var incomeCategory = <CategoryEntity>[];
  var savingCategory = <CategoryEntity>[];

  @override
  void onInit() {
    loadCategory();
    super.onInit();
  }

  Future<void> loadCategory() async {
    loading = true;

    var category = await repository.loadCategories();
    expenseCategory = category.where((element) => element.type == 3).toList();
    incomeCategory = category.where((element) => element.type == 2).toList();
    savingCategory = category.where((element) => element.type == 1).toList();

    loading = false;
    update();
  }
}
