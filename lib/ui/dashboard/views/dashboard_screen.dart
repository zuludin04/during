import 'package:during/core/widgets/bottom_navigation.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/views/nav/home_navigation.dart';
import 'package:during/ui/dashboard/views/nav/saving_navigation.dart';
import 'package:during/ui/dashboard/views/nav/setting_navigation.dart';
import 'package:during/ui/dashboard/views/nav/transaction_navigation.dart';
import 'package:during/ui/dashboard/views/widgets/add_transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigation(
            currentIndex: controller.navIndex,
            onSelectedMenu: (index) {
              if (index == 2) {
                showBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddTransactionDialog(),
                );
              } else {
                controller.changeNavIndex(index);
              }
            },
            navMenus: [
              NavMenu(label: 'home'.tr, icon: 'icon_home'),
              NavMenu(label: 'transaction'.tr, icon: 'icon_transaction'),
              NavMenu(label: '', icon: '', isCenter: true),
              NavMenu(label: 'saving'.tr, icon: 'icon_saving'),
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
