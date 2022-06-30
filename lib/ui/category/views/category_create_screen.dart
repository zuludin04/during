import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/category/controllers/category_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CategoryCreateScreen extends StatefulWidget {
  const CategoryCreateScreen({Key? key}) : super(key: key);

  @override
  State<CategoryCreateScreen> createState() => _CategoryCreateScreenState();
}

class _CategoryCreateScreenState extends State<CategoryCreateScreen> {
  final CategoryCreateController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

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
        'category'.tr,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _controller.insertCategory();
              }
            },
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: InputTextField(
                            title: 'name'.tr,
                            hint: 'name'.tr,
                            text: _controller.name.value,
                            onSaved: _controller.name,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(() {
                        return InkWell(
                          onTap: () async {
                            var result =
                                await Get.toNamed(RoutePath.categoryIcons);
                            if (result != null) {
                              _controller.icon.value = result;
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffa400),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(9),
                            child: SvgPicture.asset(
                              'assets/category/${_controller.icon.value}',
                              color: const Color(0xff373a36),
                              width: 30,
                              height: 30,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  HeaderText(title: 'type'.tr, showTrailing: false),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Obx(() {
                        return DropdownButton<String>(
                          value: _controller.type.value,
                          items: types
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              _controller.type.value = value ?? "Saving",
                          isExpanded: true,
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: _controller.isUpdate,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'delete_category_title'.tr,
                            content: Text(
                              'delete_category_message'.tr,
                              textAlign: TextAlign.center,
                            ),
                            confirm: TextButton(
                              onPressed: () {
                                Get.back();
                                _controller.deleteCategory();
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.delete_outlined,
                              color: Colors.red,
                            ),
                            Text(
                              'delete'.tr,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
}
