import 'package:carousel_slider/carousel_slider.dart';
import 'package:during/core/color_extension.dart';
import 'package:during/core/helper.dart';
import 'package:during/core/string_extension.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavingSlider extends StatelessWidget {
  final DashboardController controller;

  SavingSlider(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.savings.isNotEmpty,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 160,
              child: CarouselSlider.builder(
                itemCount: controller.savings.length,
                itemBuilder: (context, index, realIndex) {
                  return _savingCardItem(controller.savings[realIndex]);
                },
                options: CarouselOptions(
                  scrollPhysics: BouncingScrollPhysics(),
                  autoPlay: false,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _savingCardItem(SavingEntity saving) {
    return GestureDetector(
      onTap: () => Get.toNamed(RoutePath.SAVING_DETAIL, arguments: saving),
      child: Container(
        decoration: BoxDecoration(
          color: saving.color!.convertStringToColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(12),
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
                    iconAssetByCategory(saving.category ?? 'Other'),
                    width: 25,
                    height: 25,
                    color: saving.color!.dynamicTextColor(),
                  ),
                  SizedBox(width: 5),
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
                    'Type',
                    style: TextStyle(color: saving.color!.dynamicTextColor()),
                  ),
                  Text(
                    saving.category!,
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
                    'Created',
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
}
