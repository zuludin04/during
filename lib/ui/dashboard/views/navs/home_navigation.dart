import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/home_controller.dart';
import 'package:during/ui/dashboard/views/widgets/current_transactions.dart';
import 'package:during/ui/dashboard/views/widgets/transaction_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _SliverAppBarDelegate(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Text(
                'Balance',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Rp 1.000.000',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TransactionInfo(
                    controller.incomes.value, controller.expenses.value),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: TextStyle(
                        color: Color(0xffFFA400).withOpacity(0.9),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        DashboardController controller = Get.find();
                        controller.changeIndex(1);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Color(0xffFFA400),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff373A36),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ]),
          ),
          CurrentTransaction(controller),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xff373A36),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'ZM',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffFFA400),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_on_outlined,
              color: Color(0xffFFA400),
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 64;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
