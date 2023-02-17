import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/dashboard/views/widgets/saving_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SavingNavigation extends StatefulWidget {
  const SavingNavigation({Key? key}) : super(key: key);

  @override
  State<SavingNavigation> createState() => _SavingNavigationState();
}

class _SavingNavigationState extends State<SavingNavigation> {
  final HomeNavigationController _controller = Get.find();

  late BannerAd _bannerAd;
  bool _isBannerReady = false;

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
        return Column(
          children: [
            if (_isBannerReady)
              SizedBox(
                width: _bannerAd.size.width.toDouble(),
                height: 72,
                child: AdWidget(ad: _bannerAd),
              ),
            Expanded(child: EmptyLayout(message: 'empty_saving'.tr)),
          ],
        );
      } else {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  if (_isBannerReady)
                    SizedBox(
                      width: _bannerAd.size.width.toDouble(),
                      height: 72,
                      child: AdWidget(ad: _bannerAd),
                    ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return SavingCardItem(saving: _controller.savings[index]);
                }, childCount: _controller.savings.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            )
          ],
        );
      }
    });
  }
}
