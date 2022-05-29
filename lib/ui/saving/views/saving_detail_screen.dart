import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SavingDetailScreen extends StatefulWidget {
  const SavingDetailScreen({Key? key}) : super(key: key);

  @override
  State<SavingDetailScreen> createState() => _SavingDetailScreenState();
}

class _SavingDetailScreenState extends State<SavingDetailScreen> {
  final SavingEntity _saving = Get.arguments;
  final SavingDetailController _controller = Get.find();

  late BannerAd _bannerAd;
  bool _isBannerReady = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _isBannerReady = true;
        });
      }, onAdFailedToLoad: (ad, err) {
        _isBannerReady = false;
        _bannerAd.dispose();
      }),
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
            onPressed: () {
              Get.defaultDialog(
                title: '',
                content: Text(
                  'delete_saving_message'.tr,
                  textAlign: TextAlign.center,
                ),
                confirm: TextButton(
                  onPressed: () {
                    Get.back();
                    _controller.deleteSaving();
                  },
                  child: Text(
                    'ok'.tr,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                cancel: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'cancel'.tr,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Rp ${_saving.balance!.toPriceFormat()}',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  iconAssetByCategory(
                                      _saving.category ?? 'Other'),
                                  width: 35,
                                  height: 35,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  _saving.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('type'.tr),
                                Text(
                                  _saving.category ?? '',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('created'.tr),
                                Text(
                                  _saving.date!.changeDateFormat('MM/yy'),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        HeaderText(
                            title: 'transaction'.tr, showTrailing: false),
                      ],
                    ),
                  ),
                ),
                GetBuilder<SavingDetailController>(
                  builder: (controller) {
                    if (controller.loading) {
                      return _loadTransactionIndicator(true);
                    } else if (controller.empty) {
                      return _loadTransactionIndicator(false);
                    } else {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => TransactionItem(
                            transaction: controller.transactions[index],
                            source: 'saving',
                          ),
                          childCount: controller.transactions.length,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
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

  Widget _loadTransactionIndicator(bool loading) {
    return SliverFillRemaining(
      child: Center(
        child: loading
            ? const CircularProgressIndicator()
            : EmptyLayout(message: 'empty_transaction'.tr),
      ),
    );
  }
}
