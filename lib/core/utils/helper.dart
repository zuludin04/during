import 'package:during/data/model/filter_choice.dart';

final types = ['Income', 'Expense'];
final dateRangeFilters = ['Daily', 'Weekly', 'Monthly', 'Custom'];

List<FilterChoice> chipsCategory(List<String> list) {
  List<FilterChoice> filters = [];
  for (int i = 0; i < list.length; i++) {
    filters.add(FilterChoice(i + 1, list[i]));
  }
  return filters;
}

String joinText(List<String> values) {
  return "'${values.join(",")}'";
}
