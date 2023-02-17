import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/home_navigation_controller.dart';
import 'saving_card_item.dart';

class SavingSlider extends StatelessWidget {
  const SavingSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeNavigationController controller = Get.find();

    return Obx(
      () {
        if (controller.savings.isEmpty) {
          return GestureDetector(
            onTap: () {
              Get.find<DashboardController>().addSaving();
            },
            child: Container(
              width: double.infinity,
              height: _responsiveSliderHeight(context),
              margin: const EdgeInsets.symmetric(horizontal: 26),
              decoration: BoxDecoration(
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage('assets/saving_placeholder.jpg'),
                  fit: BoxFit.fill,
                  opacity: 0.5,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/navigation/icon_account.png',
                    width: 80,
                    color: const Color(0xff000000).withOpacity(0.8),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Add Your Saving',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff000000).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: _responsiveSliderHeight(context),
                child: CarouselSlider.builder(
                  itemCount: controller.savings.length,
                  itemBuilder: (context, index, realIndex) {
                    return SavingCardItem(
                        saving: controller.savings[realIndex]);
                  },
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }
      },
    );
  }

  double _responsiveSliderHeight(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (size.width > 1000) {
      return 240.0;
    } else if (size.width >= 600 && size.width <= 1000) {
      return 200.0;
    } else {
      return 160.0;
    }
  }
}
