import 'package:during/core/widgets/bottom_navigation.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/statistic_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:during/ui/dashboard/views/saving_navigation.dart';
import 'package:during/ui/dashboard/views/setting_navigation.dart';
import 'package:during/ui/dashboard/views/statistic_navigation.dart';
import 'package:during/ui/dashboard/views/transaction_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation:
                controller.navIndex == 0 || controller.navIndex == 1 ? 0 : 0.5,
            title: const Text('During'),
          ),
          bottomNavigationBar: BottomNavigation(
            currentIndex: controller.navIndex,
            onSelectedMenu: (index) async {
              if (index == 2) {
                var result =
                    await Get.toNamed(RoutePath.transactionCreate, parameters: {
                  'transaction': 'Create',
                  'type': 'Expense',
                });

                if (result != null && result == 'OK') {
                  Get.find<TransactionController>().loadSavingTotalBalance();
                  Get.find<TransactionController>().loadDailyTransactions();
                  Get.find<SavingController>().loadSavingList();
                  Get.find<StatisticController>().loadInitialStatistic();
                }
              } else {
                controller.changeNavIndex(index);
              }
            },
            navMenus: [
              NavMenu(label: 'transaction'.tr, icon: 'icon_transaction'),
              NavMenu(label: 'statistic'.tr, icon: 'icon_statistic'),
              NavMenu(label: '', icon: '', isCenter: true),
              NavMenu(label: 'account'.tr, icon: 'icon_account'),
              NavMenu(label: 'setting'.tr, icon: 'icon_settings'),
            ],
          ),
          body: IndexedStack(
            index: controller.navIndex,
            children: [
              const TransactionNavigation(),
              const StatisticNavigation(),
              Container(),
              const SavingNavigation(),
              const SettingNavigation(),
            ],
          ),
        );
      },
    );
  }
}
