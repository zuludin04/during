import 'package:during/data/source/entity/category_entity.dart';

const savingPickedType = 'saving_picked';
const savingDetailType = 'saving_detail';

/// category type
/// 1 = saving
/// 2 = income
/// 3 = expense
var initialCategories = [
  CategoryEntity(name: 'Bank', icon: 'icon_bank.svg', type: 1),
  CategoryEntity(name: 'E-Money', icon: 'icon_emoney.svg', type: 1),
  CategoryEntity(name: 'Cash', icon: 'icon_cash.svg', type: 1),
  CategoryEntity(name: 'Fee', icon: 'icon_fee.svg', type: 2),
  CategoryEntity(name: 'Bonus', icon: 'icon_bonus.svg', type: 2),
  CategoryEntity(name: 'Selling', icon: 'icon_selling.svg', type: 2),
  CategoryEntity(name: 'Education', icon: 'icon_education.svg', type: 3),
  CategoryEntity(name: 'Food', icon: 'icon_food.svg', type: 3),
  CategoryEntity(name: 'Grocery', icon: 'icon_groceries.svg', type: 3),
  CategoryEntity(name: 'Health', icon: 'icon_health.svg', type: 3),
  CategoryEntity(name: 'Home', icon: 'icon_home.svg', type: 3),
  CategoryEntity(name: 'Subscription', icon: 'icon_subcription.svg', type: 3),
  CategoryEntity(
      name: 'Transportation', icon: 'icon_transportation.svg', type: 3),
  CategoryEntity(name: 'Travel', icon: 'icon_travel.svg', type: 3),
];
