import 'package:during/core/extensions/color_extension.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/saving/controllers/saving_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SavingListScreen extends StatefulWidget {
  const SavingListScreen({Key? key}) : super(key: key);

  @override
  State<SavingListScreen> createState() => _SavingListScreenState();
}

class _SavingListScreenState extends State<SavingListScreen> {
  final SavingListController _controller = Get.find();
  final String type = Get.arguments;

  late BannerAd _bannerAd;
  bool _isBannerReady = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
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
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'saving'.tr,
        actions: [
          IconButton(
            onPressed: () async {
              var result =
                  await Get.toNamed(RoutePath.savingInsert, arguments: {
                'status': 'create',
              });
              if (result != null) {
                if (result == true) {
                  _controller.loadSavings();
                  Get.find<HomeNavigationController>().loadSavingList();
                }
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_controller.empty.value) {
                return EmptyLayout(message: 'empty_saving'.tr);
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      _savingItem(_controller.savings[index]),
                  itemCount: _controller.savings.length,
                );
              }
            }),
          ),
          if (_isBannerReady)
            SizedBox(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
        ],
      ),
    );
  }

  Widget _savingItem(SavingEntity saving) {
    return InkWell(
      onTap: () {
        if (type == savingPickedType) {
          Get.back(result: saving);
        } else {
          Get.toNamed(RoutePath.savingDetail, arguments: saving);
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
                color: saving.color!.dynamicTextColor(),
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
}
