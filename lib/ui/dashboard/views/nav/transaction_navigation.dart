import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TransactionNavigation extends StatefulWidget {
  const TransactionNavigation({super.key});

  @override
  State<TransactionNavigation> createState() => _TransactionNavigationState();
}

class _TransactionNavigationState extends State<TransactionNavigation> {
  final TransactionNavigationController _controller = Get.find();

  static const int _kAddIndex = 4;
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
      if (_controller.emptyTransaction.value) {
        return Center(
          child: EmptyLayout(message: 'empty_transaction'.tr),
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
              return TransactionItem(
                transaction:
                    _controller.transactions[_getDestinationItemIndex(index)],
                source: 'normal',
              );
            }
          },
          itemCount: _itemLength(_controller.transactions.length),
        );
      }
    });
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
