part of 'app_pages.dart';

abstract class RoutePath {
  RoutePath._();

  static const DASHBOARD = _Path.DASHBOARD;
  static const TRANSACTION_CREATE = _Path.TRANSACTION_CREATE;
  static const TRANSACTION_RECORD = _Path.TRANSACTION_RECORD;
  static const SAVING_INSERT = _Path.SAVING_INSERT;
  static const SAVING_LIST = _Path.SAVING_LIST;
}

abstract class _Path {
  static const DASHBOARD = '/';
  static const TRANSACTION_CREATE = '/transaction_create';
  static const TRANSACTION_RECORD = '/transaction_record';
  static const SAVING_INSERT = '/saving_insert';
  static const SAVING_LIST = '/saving_list';
}
