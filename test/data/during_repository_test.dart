import 'package:during/data/source/during_db_provider.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'during_repository_test.mocks.dart';
import 'fake_during_repository.dart';

@GenerateMocks([DuringDbProvider])
void main() {
  var dbProvider = MockDuringDbProvider();
  var repository = FakeDuringRepository(dbProvider);

  var mockTransactions = [
    TransactionEntity(id: 1, name: 'Hallo 1'),
    TransactionEntity(id: 2, name: 'Hallo 2'),
  ];

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
      repository.filterTransactions('range', null, null);

      verify(repository.filterTransactions('range', null, null));

      var results = await repository.filterTransactions('range', null, null);
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
}
