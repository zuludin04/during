import 'package:during/ui/dashboard/bindings/dashboard_binding.dart';
import 'package:during/ui/dashboard/bindings/home_navigation_binding.dart';
import 'package:during/ui/dashboard/bindings/setting_navigation_binding.dart';
import 'package:during/ui/dashboard/views/dashboard_screen.dart';
import 'package:during/ui/saving/bindings/saving_detail_binding.dart';
import 'package:during/ui/saving/bindings/saving_insert_binding.dart';
import 'package:during/ui/saving/bindings/saving_list_binding.dart';
import 'package:during/ui/saving/views/saving_detail_screen.dart';
import 'package:during/ui/saving/views/saving_insert_screen.dart';
import 'package:during/ui/saving/views/saving_list_screen.dart';
import 'package:during/ui/settings/settings_screen.dart';
import 'package:during/ui/transaction/bindings/transaction_create_binding.dart';
import 'package:during/ui/transaction/bindings/transaction_detail_binding.dart';
import 'package:during/ui/dashboard/bindings/transaction_filter_binding.dart';
import 'package:during/ui/transaction/views/transaction_create_screen.dart';
import 'package:during/ui/transaction/views/transaction_detail_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = _Path.DASHBOARD;

  static final routes = [
    GetPage(
      name: INITIAL,
      page: () => DashboardScreen(),
      bindings: [
        DashboardBinding(),
        HomeNavigationBinding(),
        TransactionNavigationBinding(),
        SettingNavigationBinding(),
      ],
    ),
    GetPage(
      name: _Path.TRANSACTION_CREATE,
      page: () => TransactionCreateScreen(),
      binding: TransactionCreateBinding(),
    ),
    GetPage(
      name: _Path.TRANSACTION_DETAIL,
      page: () => TransactionDetailScreen(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: _Path.SAVING_INSERT,
      page: () => SavingInsertScreen(),
      binding: SavingInsertBinding(),
    ),
    GetPage(
      name: _Path.SAVING_LIST,
      page: () => SavingListScreen(),
      binding: SavingListBinding(),
    ),
    GetPage(
      name: _Path.SAVING_DETAIL,
      page: () => SavingDetailScreen(),
      binding: SavingDetailBinding(),
    ),
    GetPage(
      name: _Path.SETTINGS,
      page: () => SettingsScreen(),
    ),
  ];
}
