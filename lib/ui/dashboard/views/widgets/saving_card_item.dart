import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/color_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../data/source/entity/saving_entity.dart';
import '../../../../routes/app_pages.dart';

class SavingCardItem extends StatelessWidget {
  final SavingEntity saving;

  const SavingCardItem({Key? key, required this.saving}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RoutePath.savingDetail, arguments: saving.id),
      child: Container(
        decoration: BoxDecoration(
          color: saving.color!.convertStringToColor().withOpacity(1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/category/${saving.categoryIcon}',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  saving.color!.dynamicTextColor(),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              saving.name!,
              style: TextStyle(
                color: saving.color!.dynamicTextColor(),
              ),
            ),
            Text(
              'Rp ${saving.balance!.toPriceFormat()}',
              style: TextStyle(
                color: saving.color!.dynamicTextColor(),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
