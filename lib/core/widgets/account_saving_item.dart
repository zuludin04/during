import 'package:during/core/extensions/color_extension.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountSavingItem extends StatelessWidget {
  final Function() onTap;
  final SavingEntity saving;
  final bool isCard;

  const AccountSavingItem({
    super.key,
    required this.onTap,
    required this.saving,
    required this.isCard,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isCard ? _cardSaving() : _savingItem(),
    );
  }

  Widget _cardSaving() {
    return Container(
      decoration: BoxDecoration(
        color: saving.color!.convertStringToColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
    );
  }

  Widget _savingItem() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(int.parse('0xff${saving.color}')),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/category/${saving.categoryIcon}',
              colorFilter: ColorFilter.mode(
                saving.color!.dynamicTextColor(),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                saving.name ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('Rp ${saving.balance!.toPriceFormat()}'),
            ],
          ),
        ],
      ),
    );
  }
}
