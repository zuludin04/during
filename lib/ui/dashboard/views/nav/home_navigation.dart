import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/dashboard/views/widgets/current_transactions.dart';
import 'package:during/ui/dashboard/views/widgets/saving_slider.dart';
import 'package:during/ui/dashboard/views/widgets/transaction_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeNavigationController controller = Get.find();
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 26),
            SavingSlider(),
            Obx(
              () => TransactionInfo(
                controller.incomes.value,
                controller.expenses.value,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      color: Color(0xffFFA400).withOpacity(0.9),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        Get.find<DashboardController>().changeNavIndex(1),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Color(0xffFFA400),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff373A36),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
          ]),
        ),
        CurrentTransaction(),
      ],
    );
  }
}
