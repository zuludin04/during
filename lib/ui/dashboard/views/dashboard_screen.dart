import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/home_controller.dart';
import 'package:during/ui/dashboard/views/navs/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var result = await Get.toNamed(RoutePath.TRANSACTION_CREATE);
              HomeController controller = Get.find();
              if (result == 'Income') {
                controller.loadIncomes();
                controller.loadTodayTransaction();
              } else if (result == 'Expense') {
                controller.loadExpenses();
                controller.loadTodayTransaction();
              }
            },
            child: Icon(
              Icons.add
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: [
              Icons.home_outlined,
              Icons.swap_horiz_outlined,
              Icons.settings_outlined,
            ],
            onTap: (index) => controller.changeIndex(index),
            activeIndex: controller.selectIndex,
            backgroundColor: Color(0xff373A36),
            activeColor: Color(0xffFFA400),
            splashColor: Color(0xff373A36),
            inactiveColor: Colors.white,
            notchSmoothness: NotchSmoothness.defaultEdge,
            gapLocation: GapLocation.end,
          ),
          body: IndexedStack(
            index: controller.selectIndex,
            children: [
              HomeNavigation(),
              bottomNavScreen('Transaction'),
              bottomNavScreen('Settings'),
            ],
          ),
        );
      },
    );
  }

  Widget bottomNavScreen(String screen) {
    return Center(
      child: Text(screen),
    );
  }
}
