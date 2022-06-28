import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/widgets/category_picker.dart';
import 'package:during/core/widgets/date_dialog.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:during/ui/transaction/views/widgets/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TransactionCreateScreen extends StatefulWidget {
  const TransactionCreateScreen({Key? key}) : super(key: key);

  @override
  State<TransactionCreateScreen> createState() =>
      _TransactionCreateScreenState();
}

class _TransactionCreateScreenState extends State<TransactionCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TransactionCreateController _controller = Get.find();

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

    if (_controller.totalTransaction % 4 == 0 && !_isInterstitialReady) {
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
      backgroundColor: Colors.white,
      appBar: ToolbarDuring.defaultToolbar(
        'transaction'.tr,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (_controller.pickedSaving.value == 'Choose Saving') {
                  Get.rawSnackbar(message: 'Pick your account saving');
                  return;
                }

                if (_controller.savingBalance() < 0) {
                  Get.rawSnackbar(
                      message: 'Your account balance will be minus.');
                  return;
                }
                _controller.createTransaction();
                if (_controller.totalTransaction % 4 == 0 &&
                    _isInterstitialReady) {
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
                TransactionType(controller: _controller),
                const SizedBox(height: 16),
                Obx(
                  () => CategoryPicker(
                    title: 'category'.tr,
                    dialogTitle: _controller.type.value == 'Income'
                        ? 'income_category'.tr
                        : 'expense_category'.tr,
                    value: _controller.category.value,
                    categories: _controller.type.value == 'Income'
                        ? _controller.incomeCategory
                        : _controller.expenseCategory,
                    onSelectedCategory: (cat) =>
                        _controller.category.value = cat.name ?? "",
                  ),
                ),
                const SizedBox(height: 16),
                HeaderText(title: 'saving'.tr, showTrailing: false),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    _controller.pickSaving();
                  },
                  child: Obx(
                    () => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _controller.pickedSaving.value == 'Choose Saving'
                            ? 'choose_saving'.tr
                            : _controller.pickedSaving.value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'total'.tr,
                  hint: 'total'.tr,
                  onSaved: _controller.nominal,
                  keyboardType: TextInputType.number,
                  text: _controller.nominal.value,
                  currencyFormat: true,
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'name'.tr,
                  hint: 'name'.tr,
                  text: _controller.name.value,
                  onSaved: _controller.name,
                ),
                const SizedBox(height: 16),
                DateDialog(
                  selectedDate: (int date) {
                    _controller.date.value = date;
                  },
                  currentDate: DateTime.fromMillisecondsSinceEpoch(
                      _controller.date.value),
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
              Get.offAndToNamed(RoutePath.dashboard,
                  result: _controller.type.value);
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
