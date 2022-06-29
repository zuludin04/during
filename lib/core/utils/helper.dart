import 'package:during/data/model/filter_choice.dart';

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
