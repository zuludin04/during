import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/utils/constants.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
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
  final SavingController _controller = Get.find();

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
        Obx(
          () => SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (_controller.savings[index].name == emptySavingHash) {
                    return _SavingEmptyItem(
                      onTap: () async {
                        var result = await Get.toNamed(RoutePath.savingInsert,
                            arguments: {'status': 'create'});
                        if (result != null && result == 'OK') {
                          Get.find<TransactionController>()
                              .loadSavingTotalBalance();
                          _controller.loadSavingList();
                        }
                      },
                    );
                  } else {
                    return SavingCardItem(saving: _controller.savings[index]);
                  }
                },
                childCount: _controller.savings.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SavingEmptyItem extends StatelessWidget {
  final Function() onTap;

  const _SavingEmptyItem({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
        padding: const EdgeInsets.all(12),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
