import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/widgets/bottom_navigation.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:during/ui/dashboard/controllers/statistic_navigation_controller.dart';
import 'package:during/ui/dashboard/views/setting_navigation.dart';
import 'package:during/ui/dashboard/views/transaction_navigation.dart';
import 'package:during/ui/dashboard/views/saving_navigation.dart';
import 'package:during/ui/dashboard/views/statistic_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime showMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            title: const Text('During'),
            bottom: _bottomToolbar(
              navIndex: controller.navIndex,
              balance: controller.totalBalance,
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
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
                  controller.loadSavingTotalBalance();
                  Get.find<TransactionController>().loadDailyTransactions();
                  Get.find<TransactionController>().loadSavingList();
                  Get.find<StatisticNavigationController>()
                      .loadInitialStatistic();
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
          body: FutureBuilder<void>(
            future: MobileAds.instance.initialize(),
            builder: (context, snapshot) {
              return IndexedStack(
                index: controller.navIndex,
                children: [
                  const TransactionNavigation(),
                  const StatisticNavigation(),
                  Container(),
                  const SavingNavigation(),
                  const SettingNavigation(),
                ],
              );
            },
          ),
        );
      },
    );
  }

  PreferredSizeWidget? _bottomToolbar({
    required int navIndex,
    required RxInt balance,
  }) {
    if (navIndex == 0) {
      return PreferredSize(
        preferredSize: const Size(double.infinity, 40),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/category/icon_emoney.svg',
                width: 30,
              ),
              const SizedBox(width: 12),
              Obx(
                () => Text(
                  'Rp ${balance.value.toPriceFormat()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (navIndex == 1) {
      return PreferredSize(
        preferredSize: const Size(double.infinity, 40),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showMonth = DateTime(showMonth.year, showMonth.month - 1);
                  var startMonth = DateTime(showMonth.year, showMonth.month, 1);
                  var endMonth =
                      DateTime(showMonth.year, showMonth.month + 1, 0);

                  Get.find<StatisticNavigationController>().loadStatisticData(
                      startMonth.millisecondsSinceEpoch,
                      endMonth.millisecondsSinceEpoch);
                });
              },
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                DateFormat("MMMM yyyy").format(showMonth),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  showMonth = DateTime(showMonth.year, showMonth.month + 1);
                });
                var startMonth = DateTime(showMonth.year, showMonth.month, 1);
                var endMonth = DateTime(showMonth.year, showMonth.month + 1, 0);

                Get.find<StatisticNavigationController>().loadStatisticData(
                    startMonth.millisecondsSinceEpoch,
                    endMonth.millisecondsSinceEpoch);
              },
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      );
    } else {
      return null;
    }
  }
}
