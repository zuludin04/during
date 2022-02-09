import 'package:during/core/widgets/bottom_navigation.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/views/widgets/dashboard_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     var result = await Get.toNamed(RoutePath.TRANSACTION_CREATE,
          //         parameters: {'transaction': 'Create'});
          //     if (result != null) {
          //       if (result == 'Income') {
          //         controller.loadIncomes();
          //         controller.loadTodayTransaction();
          //       } else if (result == 'Expense') {
          //         controller.loadExpenses();
          //         controller.loadTodayTransaction();
          //       }
          //       controller.loadSavingList();
          //     }
          //   },
          //   child: Icon(Icons.add),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: BottomNavigation(
            currentIndex: controller.navIndex,
            onSelectedMenu: controller.changeNavIndex,
            navMenus: [
              NavMenu(label: 'Home', icon: 'icon_home'),
              NavMenu(label: 'Transaction', icon: 'icon_transaction'),
              NavMenu(label: '', icon: '', isCenter: true),
              NavMenu(label: 'Saving', icon: 'icon_saving'),
              NavMenu(label: 'Setting', icon: 'icon_settings'),
            ],
          ),
          body: DashboardContent(),
        );
      },
    );
  }
}
