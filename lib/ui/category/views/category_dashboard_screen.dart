import 'package:during/core/utils/add_helper.dart';
import 'package:during/core/widgets/category_item.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CategoryDashboardScreen extends StatefulWidget {
  const CategoryDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CategoryDashboardScreen> createState() =>
      _CategoryDashboardScreenState();
}

class _CategoryDashboardScreenState extends State<CategoryDashboardScreen> {
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
      appBar: ToolbarDuring.defaultToolbar('category'.tr),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(
          RoutePath.categoryCreate,
          arguments: {
            'update': false,
            'source': 'category',
          },
        ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          GetBuilder<CategoryDashboardController>(
            builder: (controller) {
              if (controller.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: CustomScrollView(
                    slivers: [
                      _categoryTypes('saving'.tr, controller.savingCategory),
                      _categoryTypes('income'.tr, controller.incomeCategory),
                      _categoryTypes('expense'.tr, controller.expenseCategory),
                    ],
                  ),
                );
              }
            },
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

  Widget _categoryTypes(String title, List<CategoryEntity> categories) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Container(
            color: const Color(0xffF6F6F6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        if (categories.isEmpty)
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              alignment: Alignment.center,
              child: EmptyLayout(message: 'category_empty'.tr),
            ),
          ),
        if (categories.isNotEmpty)
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return CategoryItem(
                  category: categories[index],
                  onTap: (category) {
                    Get.toNamed(RoutePath.categoryCreate, arguments: {
                      'category': categories[index],
                      'update': true,
                      'source': 'category',
                    });
                  },
                );
              },
              childCount: categories.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1.1,
            ),
          ),
      ],
    );
  }
}
