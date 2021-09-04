import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/views/widgets/dashboard_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed(RoutePath.TRANSACTION_CREATE);
          DashboardController controller = Get.find();
          if (result == 'Income') {
            controller.loadIncomes();
            controller.loadTodayTransaction();
          } else if (result == 'Expense') {
            controller.loadExpenses();
            controller.loadTodayTransaction();
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: DashboardContent(),
    );
  }

  Widget bottomNavScreen(String screen) {
    return Center(
      child: Text(screen),
    );
  }
}
