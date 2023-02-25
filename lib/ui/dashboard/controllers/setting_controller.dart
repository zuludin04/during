import 'package:during/data/during_repository.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final DuringRepository _repository = Get.find();

  void toggleDarkTheme(bool theme) {
    CacheService.to.darkMode = theme;
  }

  void resetData() async {
    _repository.resetAllData().then((value) {
      Get.find<SavingController>().loadSavingList();
      Get.find<TransactionController>().loadDailyTransactions();
      Get.find<DashboardController>().changeNavIndex(0);
    });
  }
}
