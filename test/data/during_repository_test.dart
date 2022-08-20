import 'package:during/data/source/during_db_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/dummy_data.dart';
import 'during_repository_test.mocks.dart';
import 'fake_during_repository.dart';

@GenerateMocks([DuringDbProvider])
void main() {
  var dbProvider = MockDuringDbProvider();
  var repository = FakeDuringRepository(dbProvider);

  group('test daily expense and income', () {
    test('load daily expense', () async {
      when(dbProvider.totalExpense(1, 3)).thenAnswer((_) async => 10);

      repository.countTotalExpense(1, 3);

      verify(repository.countTotalExpense(1, 3));
      expect(await repository.countTotalExpense(1, 3), 10);
    });

    test('load daily income', () async {
      when(dbProvider.totalIncome(1, 5)).thenAnswer((_) async => 100);

      repository.countTotalIncome(1, 5);

      verify(repository.countTotalIncome(1, 5));
      expect(await repository.countTotalIncome(1, 5), 100);
    });
  });

  group('test to get transaction item list', () {
    test('load filter transactions', () async {
      when(dbProvider.filterTransactions(any))
          .thenAnswer((_) async => mockTransactions);
      repository.filterTransactions('range', null, null, null);

      verify(repository.filterTransactions('range', null, null, null));

      var results =
          await repository.filterTransactions('range', null, null, null);
      expect(results, mockTransactions);
      expect(results.isNotEmpty, true);
      expect(results.length, mockTransactions.length);
    });

    test('load transaction by budget id', () async {
      when(dbProvider.loadBudgetTransactions(any))
          .thenAnswer((_) async => mockTransactions);
      repository.loadBudgetTransactions(1);

      verify(repository.loadBudgetTransactions(1));

      var results = await repository.loadBudgetTransactions(1);
      expect(results, mockTransactions);
      expect(results.isNotEmpty, true);
      expect(results.length, mockTransactions.length);
    });

    test('load daily transactions', () async {
      when(dbProvider.loadDailyTransactions(any, any))
          .thenAnswer((_) async => mockTransactions);
      repository.loadDailyTransactions(1, 4);

      verify(repository.loadDailyTransactions(1, 4));

      var results = await repository.loadDailyTransactions(1, 4);
      expect(results, mockTransactions);
      expect(results.isNotEmpty, true);
      expect(results.length, mockTransactions.length);
    });

    test('load transactions by saving id', () async {
      when(dbProvider.loadSavingTransactions(any))
          .thenAnswer((_) async => mockTransactions);
      repository.loadSavingTransactions(1);

      verify(repository.loadSavingTransactions(1));

      var results = await repository.loadSavingTransactions(1);
      expect(results, mockTransactions);
      expect(results.isNotEmpty, true);
      expect(results.length, mockTransactions.length);
    });

    test('load all transactions', () async {
      when(dbProvider.loadDuringTransactions())
          .thenAnswer((_) async => mockTransactions);
      repository.loadTransactions();

      verify(repository.loadTransactions());

      var results = await repository.loadTransactions();
      expect(results, mockTransactions);
      expect(results.isNotEmpty, true);
      expect(results.length, mockTransactions.length);
    });
  });

  group('test to get saving list and detail data', () {
    test('load all savings item', () async {
      when(dbProvider.loadSavings()).thenAnswer((_) async => mockSavings);
      repository.loadSaving();

      verify(repository.loadSaving());

      var results = await repository.loadSaving();
      expect(results, mockSavings);
      expect(results.isNotEmpty, true);
      expect(results.length, mockSavings.length);
    });

    test('laod detail saving', () async {
      when(dbProvider.loadSingleSaving(any))
          .thenAnswer((_) async => mockSavings[0]);
      repository.loadSingleSaving(1);

      verify(repository.loadSingleSaving(1));

      var result = await repository.loadSingleSaving(1);
      expect(result, mockSavings[0]);
      expect(result.id, mockSavings[0].id);
    });
  });

  group('test to get all category data', () {
    test('load all category items', () async {
      when(dbProvider.loadCategories()).thenAnswer((_) async => mockCategory);
      repository.loadCategories();

      verify(repository.loadCategories());

      var categories = await repository.loadCategories();
      expect(categories, mockCategory);
      expect(categories.isNotEmpty, true);
      expect(categories.length, mockCategory.length);
    });

    test('load categories by type', () async {
      when(dbProvider.loadCategoryByType(any))
          .thenAnswer((_) async => mockCategory);
      repository.loadCategoryType(1);

      verify(repository.loadCategoryType(1));

      var categories = await repository.loadCategoryType(1);
      expect(categories, mockCategory);
      expect(categories.isNotEmpty, true);
      expect(categories.length, mockCategory.length);
    });

    test('load category detail data', () async {
      when(dbProvider.loadSingleCategory(any))
          .thenAnswer((_) async => mockCategory[0]);
      repository.loadSingleCategory(1);

      verify(repository.loadSingleCategory(1));

      var categories = await repository.loadSingleCategory(1);
      expect(categories, mockCategory[0]);
      expect(categories.id, mockCategory[0].id);
    });
  });

  group('test to budget items', () {
    test('load all budgets', () async {
      when(dbProvider.loadBudgets()).thenAnswer((_) async => mockBudget);
      repository.loadBudgets();

      verify(repository.loadBudgets());

      var budgets = await repository.loadBudgets();
      expect(budgets, mockBudget);
      expect(budgets.isNotEmpty, true);
      expect(budgets.length, mockBudget.length);
    });
  });
}
