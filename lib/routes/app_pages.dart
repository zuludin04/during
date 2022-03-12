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
import 'package:during/ui/share/bindings/share_payment_binding.dart';
import 'package:during/ui/share/views/share_generated_code_screen.dart';
import 'package:during/ui/share/views/share_payment_screen.dart';
import 'package:during/ui/transaction/bindings/transaction_create_binding.dart';
import 'package:during/ui/transaction/bindings/transaction_detail_binding.dart';
import 'package:during/ui/dashboard/bindings/transaction_filter_binding.dart';
import 'package:during/ui/transaction/views/transaction_create_screen.dart';
import 'package:during/ui/transaction/views/transaction_detail_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = RoutePath.dashboard;

  static final routes = [
    GetPage(
      name: initial,
      page: () => DashboardScreen(),
      bindings: [
        DashboardBinding(),
        HomeNavigationBinding(),
        TransactionNavigationBinding(),
        SettingNavigationBinding(),
      ],
    ),
    GetPage(
      name: RoutePath.transactionCreate,
      page: () => TransactionCreateScreen(),
      binding: TransactionCreateBinding(),
    ),
    GetPage(
      name: RoutePath.transactionDetail,
      page: () => TransactionDetailScreen(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: RoutePath.savingInsert,
      page: () => SavingInsertScreen(),
      binding: SavingInsertBinding(),
    ),
    GetPage(
      name: RoutePath.savingList,
      page: () => SavingListScreen(),
      binding: SavingListBinding(),
    ),
    GetPage(
      name: RoutePath.savingDetail,
      page: () => SavingDetailScreen(),
      binding: SavingDetailBinding(),
    ),
    GetPage(
      name: RoutePath.settings,
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: RoutePath.sharePayment,
      page: () => SharePaymentScreen(),
      binding: SharePaymentBinding(),
    ),
    GetPage(
      name: RoutePath.generatedCode,
      page: () => ShareGeneratedCodeScreen(),
    ),
  ];
}
