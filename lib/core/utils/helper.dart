import 'package:during/data/model/filter_choice.dart';

String iconAssetByCategory(String category) {
  switch (category) {
    case 'Education':
      return 'assets/category/icon_education.svg';
    case 'Food':
      return 'assets/category/icon_food.svg';
    case 'Grocery':
      return 'assets/category/icon_groceries.svg';
    case 'Health':
      return 'assets/category/icon_health.svg';
    case 'Home':
      return 'assets/category/icon_home.svg';
    case 'Subscription':
      return 'assets/category/icon_subcription.svg';
    case 'Transportation':
      return 'assets/category/icon_transportation.svg';
    case 'Travel':
      return 'assets/category/icon_travel.svg';
    case 'Fee':
      return 'assets/category/icon_fee.svg';
    case 'Bonus':
      return 'assets/category/icon_bonus.svg';
    case 'Selling':
      return 'assets/category/icon_selling.svg';
    case 'Bank':
      return 'assets/category/icon_bank.svg';
    case 'E-Money':
      return 'assets/category/icon_emoney.svg';
    case 'Cash':
      return 'assets/category/icon_cash.svg';
    default:
      return 'assets/category/icon_other.svg';
  }
}

final types = ['Income', 'Expense'];
final expenseCategories = [
  'Education',
  'Food',
  'Grocery',
  'Health',
  'Home',
  'Subscription',
  'Transportation',
  'Travel',
  'Other'
];
final incomeCategories = ['Fee', 'Bonus', 'Selling'];
final savingCategories = ['Bank', 'E-Money', 'Cash'];
final dateRangeFilters = ['Daily', 'Weekly', 'Monthly'];

List<FilterChoice> chipsCategory(List<String> list) {
  List<FilterChoice> filters = [];
  for (int i = 0; i < list.length; i++) {
    filters.add(FilterChoice(i + 1, list[i]));
  }
  return filters;
}
