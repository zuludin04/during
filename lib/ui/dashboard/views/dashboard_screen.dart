import 'package:during/core/widgets/bottom_navigation.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/views/nav/home_navigation.dart';
import 'package:during/ui/dashboard/views/nav/saving_navigation.dart';
import 'package:during/ui/dashboard/views/nav/setting_navigation.dart';
import 'package:during/ui/dashboard/views/nav/transaction_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            title: const Text('During'),
            actions: [
              if (controller.navIndex == 1)
                IconButton(
                  onPressed: controller.filterTransaction,
                  icon: const Icon(
                    Icons.filter_list,
                    color: Color(0xff373A36),
                  ),
                ),
              if (controller.navIndex == 3)
                IconButton(
                  onPressed: controller.addSaving,
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xff373A36),
                  ),
                ),
            ],
            bottom: PreferredSize(
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
                    const Text('Balance: Rp 6.000.000'),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            currentIndex: controller.navIndex,
            onSelectedMenu: (index) async {
              if (index == 2) {
                Get.toNamed(RoutePath.transactionCreate, parameters: {
                  'transaction': 'Create',
                  'type': 'Expense',
                });
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
                  const HomeNavigation(),
                  const TransactionNavigation(),
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
}
