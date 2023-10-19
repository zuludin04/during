import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SavingNavigation extends StatefulWidget {
  const SavingNavigation({super.key});

  @override
  State<SavingNavigation> createState() => _SavingNavigationState();
}

class _SavingNavigationState extends State<SavingNavigation> {
  final HomeNavigationController _controller = Get.find();

  late BannerAd _bannerAd;
  bool _isBannerReady = false;
  static const int _kAddIndex = 3;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerReady = false;
          _bannerAd.dispose();
        },
      ),
      request: const AdRequest(),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.emptySaving.value) {
        return Center(
          child: EmptyLayout(message: 'empty_saving'.tr),
        );
      } else {
        return ListView.builder(
          itemBuilder: (context, index) {
            if (_isBannerReady && index == _kAddIndex) {
              return SizedBox(
                width: _bannerAd.size.width.toDouble(),
                height: 72,
                child: AdWidget(ad: _bannerAd),
              );
            } else {
              return _savingItem(
                  _controller.savings[_getDestinationItemIndex(index)]);
            }
          },
          itemCount: _itemLength(_controller.savings.length),
        );
      }
    });
  }

  Widget _savingItem(SavingEntity saving) {
    return InkWell(
      onTap: () async {
        var result =
            await Get.toNamed(RoutePath.savingDetail, arguments: saving);
        if (result != null) {
          if (result == true) {
            _controller.loadSavingList();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(int.parse('0x${saving.color}')),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/category/${saving.categoryIcon}',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
      ),
    );
  }

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAddIndex && _isBannerReady) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  int _itemLength(int total) {
    if (total >= _kAddIndex && _isBannerReady) {
      return total + 1;
    }
    return total;
  }
}
