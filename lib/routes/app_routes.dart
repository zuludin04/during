part of 'app_pages.dart';

abstract class RoutePath {
  RoutePath._();

  static const dashboard = '/';
  static const transactionCreate = '/transaction_create';
  static const transactionRecord = '/transaction_record';
  static const transactionDetail = '/transaction_detail';
  static const savingInsert = '/saving_insert';
  static const savingList = '/saving_list';
  static const savingDetail = '/saving_detail';
  static const language = '/language';
  static const category = '/category';
  static const categoryIcons = '/category_icons';
  static const categoryCreate = '/category_create';
}
