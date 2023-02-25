import 'package:during/core/utils/ad_helper.dart';
import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/category_picker.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/saving/controllers/saving_insert_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SavingInsertScreen extends StatefulWidget {
  const SavingInsertScreen({Key? key}) : super(key: key);

  @override
  State<SavingInsertScreen> createState() => _SavingInsertScreenState();
}

class _SavingInsertScreenState extends State<SavingInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final SavingInsertController _controller = Get.find();

  late BannerAd _bannerAd;
  InterstitialAd? _interstitialAd;

  bool _isBannerReady = false;
  bool _isInterstitialReady = false;

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

    if (_controller.totalSaving % 2 == 0 && !_isInterstitialReady) {
      _loadInterstitialAds();
    }
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'insert'.tr,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _controller.insertSaving();
                if (_controller.totalSaving % 2 == 0 && _isInterstitialReady) {
                  _interstitialAd?.show();
                }
              }
            },
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Obx(
                  () => CategoryPicker(
                    title: 'category'.tr,
                    dialogTitle: 'saving_category'.tr,
                    value: _controller.selectedCategory.value.name ?? "",
                    categories: _controller.savingCategory,
                    onSelectedCategory: (cat) =>
                        _controller.selectedCategory.value = cat,
                  ),
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'name'.tr,
                  hint: 'name'.tr,
                  onSaved: _controller.name,
                  text: _controller.name.value,
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'balance'.tr,
                  hint: 'balance'.tr,
                  onSaved: _controller.balance,
                  keyboardType: TextInputType.phone,
                  text: _controller.balance.value,
                  currencyFormat: true,
                ),
                const SizedBox(height: 16),
                HeaderText(title: 'color'.tr, showTrailing: false),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Obx(() {
                      return DropdownButton<String>(
                        value: _controller.color.value,
                        items: categoryColors
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 72,
                                      decoration: BoxDecoration(
                                        color: Color(int.parse('0xff$e')),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          _controller.color.value = value ?? "F44336";
                        },
                        isExpanded: true,
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 32),
                if (_isBannerReady)
                  SizedBox(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadInterstitialAds() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Get.offAndToNamed(RoutePath.dashboard, result: true);
            },
          );

          _isInterstitialReady = true;
        },
        onAdFailedToLoad: (err) {
          _isInterstitialReady = false;
        },
      ),
    );
  }
}
