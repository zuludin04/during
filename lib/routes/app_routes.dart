part of 'app_pages.dart';

abstract class RoutePath {
  RoutePath._();

  static const DASHBOARD = _Path.DASHBOARD;
  static const TRANSACTION_CREATE = _Path.TRANSACTION_CREATE;
  static const TRANSACTION_RECORD = _Path.TRANSACTION_RECORD;
  static const TRANSACTION_DETAIL = _Path.TRANSACTION_DETAIL;
  static const SAVING_INSERT = _Path.SAVING_INSERT;
  static const SAVING_LIST = _Path.SAVING_LIST;
  static const SAVING_DETAIL = _Path.SAVING_DETAIL;
  static const SETTINGS = _Path.SETTINGS;
  static const SHARE_PAYMENT = _Path.SHARE_PAYMENT;
}

abstract class _Path {
  static const DASHBOARD = '/';
  static const TRANSACTION_CREATE = '/transaction_create';
  static const TRANSACTION_RECORD = '/transaction_record';
  static const TRANSACTION_DETAIL = '/transaction_detail';
  static const SAVING_INSERT = '/saving_insert';
  static const SAVING_LIST = '/saving_list';
  static const SAVING_DETAIL = '/saving_detail';
  static const SETTINGS = '/settings';
  static const SHARE_PAYMENT = '/share_payment';
}
