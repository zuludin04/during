import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/dashboard/views/widgets/current_transactions.dart';
import 'package:during/ui/dashboard/views/widgets/saving_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeNavigationController controller = Get.find();
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(height: 26),
            Obx(
              () => Visibility(
                visible: !controller.hideSlider.value,
                child: const SavingSlider(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'recent_transaction'.tr,
                    style: TextStyle(
                      color: const Color(0xffFFA400).withOpacity(0.9),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        Get.find<DashboardController>().changeNavIndex(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFA400),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'see_all'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ]),
        ),
        CurrentTransaction(),
      ],
    );
  }
}
