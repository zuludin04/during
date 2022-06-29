import 'package:during/core/extensions/color_extension.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/transaction/controllers/transaction_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen({Key? key}) : super(key: key);

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final TransactionDetailController _controller = Get.find();

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
      appBar: ToolbarDuring.defaultToolbar('detail_transaction'.tr),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<TransactionDetailController>(
                    builder: (controller) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        color: controller.transaction.color!
                            .convertStringToColor(),
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              text: '${'from'.tr} ',
                              style: TextStyle(
                                fontSize: 16,
                                color: controller.transaction.color!
                                    .dynamicTextColor(),
                              ),
                              children: [
                                TextSpan(
                                  text: controller.saving,
                                  style: TextStyle(
                                    color: controller.transaction.color!
                                        .dynamicTextColor(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Rp ${_controller.transaction.nominal!.toPriceFormat()}',
                    style: TextStyle(
                      fontSize: 26,
                      color: _controller.transaction.type == 'Income'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _controller.transaction.date!
                        .changeDateFormat('dd MMM yyyy, HH:mm'),
                    style: const TextStyle(color: Colors.black87),
                  ),
                  _transactionInfo('Name', '${_controller.transaction.name}'),
                  _transactionInfo('Type', '${_controller.transaction.type}'),
                  _transactionInfo(
                      'Category', '${_controller.transaction.categoryName}'),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.black12, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: '',
                            content: Text(
                              'delete_transaction_message'.tr,
                              textAlign: TextAlign.center,
                            ),
                            confirm: TextButton(
                              onPressed: () {
                                Get.back();
                                _controller.deleteTransaction();
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
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: _controller.updateTransaction,
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ],
              ),
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

  Widget _transactionInfo(String header, String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          HeaderText(
            title: header.toLowerCase().tr,
            showTrailing: false,
            titleSize: 15,
          ),
          Text(
            item.toLowerCase().tr,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
