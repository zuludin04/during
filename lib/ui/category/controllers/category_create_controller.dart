import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:get/get.dart';

class CategoryCreateController extends GetxController {
  final DuringRepository _repository = Get.find();

  var name = ''.obs;
  var icon = 'icon_wallet.svg'.obs;
  var type = 'Saving'.obs;

  bool isUpdate = Get.arguments['update'];
  CategoryEntity category = CategoryEntity();

  @override
  void onInit() {
    if (isUpdate) {
      category = Get.arguments['category'];
      _initCategoryValue();
    }
    super.onInit();
  }

  void insertCategory() async {
    var category = CategoryEntity(
      name: name.value,
      icon: icon.value,
      type: _typeToInt(type.value),
    );

    if (isUpdate) {
      category.id = this.category.id;
      _repository.updateCategory(category).then((value) {
        Get.find<CategoryDashboardController>().loadCategory();
        Get.back();
      });
    } else {
      _repository.inserteCategroy(category).then((value) {
        Get.find<CategoryDashboardController>().loadCategory();
        Get.back();
      });
    }
  }

  void deleteCategory() async {
    await _repository.deleteCategory(category.id);

    Get.find<CategoryDashboardController>().loadCategory();
    Get.find<HomeNavigationController>().loadTodayTransaction();
    Get.find<HomeNavigationController>().loadIncomes();
    Get.find<HomeNavigationController>().loadExpenses();
    Get.find<TransactionNavigationController>().loadInitialTransactions();
    Get.back();
  }

  void _initCategoryValue() {
    name.value = category.name!;
    icon.value = category.icon!;
    type.value = _typeToString(category.type!);
  }

  int _typeToInt(String type) {
    switch (type) {
      case 'Saving':
        return 1;
      case 'Income':
        return 2;
      case 'Expense':
        return 3;
      default:
        return 1;
    }
  }

  String _typeToString(int type) {
    switch (type) {
      case 1:
        return 'Saving';
      case 2:
        return 'Income';
      case 3:
        return 'Expense';
      default:
        return 'Saving';
    }
  }
}
