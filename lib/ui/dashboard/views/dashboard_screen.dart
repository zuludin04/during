import 'package:during/core/widgets/bottom_navigation.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/home_controller.dart';
import 'package:during/ui/dashboard/views/nav/home_navigation.dart';
import 'package:during/ui/dashboard/views/nav/saving_navigation.dart';
import 'package:during/ui/dashboard/views/nav/setting_navigation.dart';
import 'package:during/ui/dashboard/views/nav/transaction_navigation.dart';
import 'package:during/ui/dashboard/views/widgets/add_transaction_dialog.dart';
import 'package:during/ui/transaction/controllers/transaction_filter_controller.dart';
import 'package:during/ui/transaction/views/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: Text(
              'During',
              style: TextStyle(
                color: Color(0xff111410),
                fontSize: 18,
              ),
            ),
            actions: [
              if (controller.navIndex == 1)
                IconButton(
                  onPressed: controller.filterTransaction,
                  icon: Icon(
                    Icons.filter_list,
                    color: Color(0xff373A36),
                  ),
                ),
              if (controller.navIndex == 3)
                IconButton(
                  onPressed: controller.addSaving,
                  icon: Icon(
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
                showMaterialModalBottomSheet(
                  expand: false,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddTransactionDialog(),
                );
              } else {
                controller.changeNavIndex(index);
              }
            },
            navMenus: [
              NavMenu(label: 'Home', icon: 'icon_home'),
              NavMenu(label: 'Transaction', icon: 'icon_transaction'),
              NavMenu(label: '', icon: '', isCenter: true),
              NavMenu(label: 'Saving', icon: 'icon_saving'),
              NavMenu(label: 'Setting', icon: 'icon_settings'),
            ],
          ),
          body: IndexedStack(
            index: controller.navIndex,
            children: [
              HomeNavigation(),
              TransactionNavigation(),
              Container(),
              SavingNavigation(),
              SettingNavigation(),
            ],
          ),
        );
      },
    );
  }
}
