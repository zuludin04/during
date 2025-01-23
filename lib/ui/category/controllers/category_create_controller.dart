import 'package:during/core/utils/base_controller.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/statistic_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:during/ui/saving/controllers/saving_insert_controller.dart';
import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:get/get.dart';

class CategoryCreateController extends BaseController {
  var name = ''.obs;
  var icon = 'icon_wallet.svg'.obs;
  var type = 'Saving'.obs;
  var color = 'F44336'.obs;

  bool isUpdate = Get.arguments['update'];
  String source = Get.arguments['source'];
  CategoryEntity category = CategoryEntity();

  @override
  void onInit() {
    if (isUpdate) {
      category = Get.arguments['category'];
      _initCategoryValue();
    } else {
      _setCategoryType();
    }
    super.onInit();
  }

  void insertCategory() async {
    if (name.value == '') {
      Get.rawSnackbar(message: 'Category name cant be empty');
      return;
    }
    var category = CategoryEntity(
      name: name.value,
      icon: icon.value,
      type: _typeToInt(type.value),
      color: color.value,
    );

    if (isUpdate) {
      category.id = this.category.id;
      repository.updateCategory(category).then((value) {
        if (source == 'category') {
          Get.find<CategoryDashboardController>().loadCategory();
          Get.find<TransactionController>().loadDailyTransactions();
          Get.find<StatisticController>().loadInitialStatistic();
        }
        _updateCategoryListDialog();
        Get.back();
      });
    } else {
      repository.inserteCategroy(category).then((value) {
        if (source == 'category') {
          Get.find<CategoryDashboardController>().loadCategory();
        }
        _updateCategoryListDialog();
        Get.back();
      });
    }
  }

  void deleteCategory() async {
    await repository.deleteCategory(category.id);

    Get.find<CategoryDashboardController>().loadCategory();
    Get.find<TransactionController>().loadDailyTransactions();
    Get.back();
  }

  void _updateCategoryListDialog() {
    switch (source) {
      case 'Income Category':
      case 'Expense Category':
        Get.find<TransactionCreateController>().loadCategory();
        break;
      case 'Saving Category':
        Get.find<SavingInsertController>().loadCategory();
        break;
    }
  }

  void _setCategoryType() {
    switch (source) {
      case 'Income Category':
        type.value = 'Income';
        break;
      case 'Expense Category':
        type.value = 'Expense';
        break;
      case 'Saving Category':
        type.value = 'Saving';
        break;
      default:
        type.value = 'Saving';
        break;
    }
  }

  void _initCategoryValue() {
    name.value = category.name!;
    icon.value = category.icon!;
    type.value = _typeToString(category.type!);
    color.value = category.color!;
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
