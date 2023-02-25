import 'package:during/ui/category/bindings/category_create_binding.dart';
import 'package:during/ui/category/bindings/category_dashboard_binding.dart';
import 'package:during/ui/category/views/category_create_screen.dart';
import 'package:during/ui/category/views/category_dashboard_screen.dart';
import 'package:during/ui/category/views/category_icons_screen.dart';
import 'package:during/ui/dashboard/bindings/dashboard_binding.dart';
import 'package:during/ui/dashboard/bindings/saving_binding.dart';
import 'package:during/ui/dashboard/bindings/setting_binding.dart';
import 'package:during/ui/dashboard/bindings/statistic_binding.dart';
import 'package:during/ui/dashboard/bindings/transaction_binding.dart';
import 'package:during/ui/dashboard/views/dashboard_screen.dart';
import 'package:during/ui/saving/bindings/saving_detail_binding.dart';
import 'package:during/ui/saving/bindings/saving_insert_binding.dart';
import 'package:during/ui/saving/bindings/saving_manage_binding.dart';
import 'package:during/ui/saving/views/saving_detail_screen.dart';
import 'package:during/ui/saving/views/saving_insert_screen.dart';
import 'package:during/ui/saving/views/saving_manage_screen.dart';
import 'package:during/ui/transaction/bindings/transaction_create_binding.dart';
import 'package:during/ui/transaction/bindings/transaction_detail_binding.dart';
import 'package:during/ui/transaction/views/transaction_create_screen.dart';
import 'package:during/ui/transaction/views/transaction_detail_screen.dart';
import 'package:during/ui/transfer/bindings/transfer_binding.dart';
import 'package:during/ui/transfer/views/transfer_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = RoutePath.dashboard;

  static final routes = [
    GetPage(
      name: initial,
      page: () => const DashboardScreen(),
      bindings: [
        DashboardBinding(),
        TransactionBinding(),
        SavingBinding(),
        SettingBinding(),
        StatisticBinding(),
      ],
    ),
    GetPage(
      name: RoutePath.transactionCreate,
      page: () => const TransactionCreateScreen(),
      binding: TransactionCreateBinding(),
    ),
    GetPage(
      name: RoutePath.transactionDetail,
      page: () => const TransactionDetailScreen(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: RoutePath.savingInsert,
      page: () => const SavingInsertScreen(),
      binding: SavingInsertBinding(),
    ),
    GetPage(
      name: RoutePath.savingList,
      page: () => const SavingManageScreen(),
      binding: SavingManageBinding(),
    ),
    GetPage(
      name: RoutePath.savingDetail,
      page: () => const SavingDetailScreen(),
      binding: SavingDetailBinding(),
    ),
    GetPage(
      name: RoutePath.category,
      page: () => const CategoryDashboardScreen(),
      binding: CategoryDashboardBinding(),
    ),
    GetPage(
      name: RoutePath.categoryIcons,
      page: () => CategoryIconsScreen(),
    ),
    GetPage(
      name: RoutePath.categoryCreate,
      page: () => const CategoryCreateScreen(),
      binding: CategoryCreateBinding(),
    ),
    GetPage(
      name: RoutePath.transfer,
      page: () => const TransferScreen(),
      binding: TransferBinding(),
    ),
  ];
}
