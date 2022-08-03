import 'package:during/data/source/entity/budget_entity.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';

var mockCategory = [
  CategoryEntity(id: 1, name: 'Category 1'),
  CategoryEntity(id: 2, name: 'Category 2'),
];

var mockTransactions = [
  TransactionEntity(id: 1, name: 'Hallo 1'),
  TransactionEntity(id: 2, name: 'Hallo 2'),
];

var mockSavings = [
  SavingEntity(id: 1, name: 'Saving 1'),
  SavingEntity(id: 2, name: 'Saving 2'),
];

var mockBudget = [
  BudgetEntity(id: 1, name: 'Budget 1'),
  BudgetEntity(id: 2, name: 'Budget 2'),
];

var mockCagoriesWithType = [
  CategoryEntity(id: 1, name: 'Category 1', type: 1),
  CategoryEntity(id: 2, name: 'Category 2', type: 1),
  CategoryEntity(id: 3, name: 'Category 3', type: 2),
  CategoryEntity(id: 4, name: 'Category 4', type: 2),
  CategoryEntity(id: 5, name: 'Category 5', type: 3),
  CategoryEntity(id: 6, name: 'Category 6', type: 3),
];
