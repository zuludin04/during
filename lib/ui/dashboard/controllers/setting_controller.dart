import 'package:during/core/utils/base_controller.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/statistic_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:get/get.dart';

class SettingController extends BaseController {
  void toggleDarkTheme(bool theme) {
    CacheService.to.darkMode = theme;
  }

  void resetData() async {
    repository.resetAllData().then((value) {
      Get.find<SavingController>().loadSavingList();
      Get.find<TransactionController>().loadDailyTransactions();
      Get.find<TransactionController>().loadSavingTotalBalance();
      Get.find<StatisticController>().loadInitialStatistic();
      Get.find<DashboardController>().changeNavIndex(0);
    });
  }
}
