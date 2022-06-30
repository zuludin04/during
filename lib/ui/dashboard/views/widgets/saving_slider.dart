import 'package:carousel_slider/carousel_slider.dart';
import 'package:during/core/extensions/color_extension.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavingSlider extends StatelessWidget {
  final HomeNavigationController controller = Get.find();

  SavingSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.savings.isNotEmpty,
        child: Column(
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
        ),
      ),
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
