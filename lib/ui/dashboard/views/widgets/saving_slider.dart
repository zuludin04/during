import 'package:carousel_slider/carousel_slider.dart';
import 'package:during/core/extensions/color_extension.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
                  SvgPicture.asset(
                    'assets/navigation/icon_saving.svg',
                    width: 35,
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
                    return _savingCardItem(controller.savings[realIndex]);
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

  Widget _savingCardItem(SavingEntity saving) {
    return InkWell(
      onTap: () => Get.toNamed(RoutePath.savingDetail, arguments: saving),
      child: Container(
        decoration: BoxDecoration(
          color: saving.color!.convertStringToColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Rp ${saving.balance!.toPriceFormat()}',
                style: TextStyle(
                  fontSize: 20,
                  color: saving.color!.dynamicTextColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/category/${saving.categoryIcon}',
                    width: 25,
                    height: 25,
                    color: saving.color!.dynamicTextColor(),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    saving.name!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: saving.color!.dynamicTextColor(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'type'.tr,
                    style: TextStyle(color: saving.color!.dynamicTextColor()),
                  ),
                  Text(
                    saving.categoryName!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: saving.color!.dynamicTextColor(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'created'.tr,
                    style: TextStyle(color: saving.color!.dynamicTextColor()),
                  ),
                  Text(
                    saving.date!.changeDateFormat('MM/yy'),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: saving.color!.dynamicTextColor(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
