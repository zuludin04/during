import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/color_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../data/source/entity/saving_entity.dart';
import '../../../../routes/app_pages.dart';

class SavingCardItem extends StatefulWidget {
  final SavingEntity saving;

  const SavingCardItem({Key? key, required this.saving}) : super(key: key);

  @override
  State<SavingCardItem> createState() => _SavingCardItemState();
}

class _SavingCardItemState extends State<SavingCardItem> {
  bool showNominal = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(RoutePath.savingDetail, arguments: widget.saving),
      child: Container(
        decoration: BoxDecoration(
          color: widget.saving.color!.convertStringToColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _savingNominal(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showNominal = !showNominal;
                      });
                    },
                    icon: Icon(
                     !showNominal ? Icons.visibility : Icons.visibility_off,
                      size: 20,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/category/${widget.saving.categoryIcon}',
                    width: 25,
                    height: 25,
                    color: widget.saving.color!.dynamicTextColor(),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.saving.name!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.saving.color!.dynamicTextColor(),
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
                    style: TextStyle(
                        color: widget.saving.color!.dynamicTextColor()),
                  ),
                  Text(
                    widget.saving.categoryName!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: widget.saving.color!.dynamicTextColor(),
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
                    style: TextStyle(
                        color: widget.saving.color!.dynamicTextColor()),
                  ),
                  Text(
                    widget.saving.date!.changeDateFormat('MM/yy'),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: widget.saving.color!.dynamicTextColor(),
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

  Widget _savingNominal() {
    if (showNominal) {
      return Text(
        'Rp ${widget.saving.balance!.toPriceFormat()}',
        style: TextStyle(
          fontSize: 20,
          color: widget.saving.color!.dynamicTextColor(),
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Row(
        children: List.generate(
          5,
          (index) => Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
  }
}
