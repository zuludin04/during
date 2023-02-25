import 'package:during/data/during_repository.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/service/language_service.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final DuringRepository _repository = Get.find();

  var navIndex = 0;
  var totalBalance = 0.obs;

  void changeNavIndex(int index) {
    navIndex = index;
    update();
  }

  @override
  void onInit() {
    Get.updateLocale(LanguageService.deviceLocale);
    loadInitialCategory();
    loadSavingTotalBalance();
    super.onInit();
  }

  void loadInitialCategory() {
    if (!CacheService.to.loadInitialCategory) {
      _repository
          .initialCategory()
          .then((value) => CacheService.to.loadInitialCategory = true);
    }
  }

  void loadSavingTotalBalance() async {
    var balance = await _repository.loadTotalSavingBalance();
    totalBalance.value = balance;
  }

  void addSaving() async {
    var result = await Get.toNamed(RoutePath.savingInsert, arguments: {
      'status': 'create',
    });
    if (result != null) {
      if (result == true) {
        Get.find<TransactionController>().loadSavingList();
      }
    }
  }

  void resetData() async {
    _repository.resetAllData().then((value) {
      Get.find<TransactionController>().loadSavingList();
      Get.find<TransactionController>().loadDailyTransactions();
      changeNavIndex(0);
    });
  }
}
