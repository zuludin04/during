import 'package:collection/collection.dart';
import 'package:during/data/source/during_db_provider.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';

abstract class DuringRepository {
  Future<void> saveTransaction(TransactionEntity transaction);

  Future<void> deleteTransaction(int? id);

  Future<List<TransactionEntity>> loadTodayTransaction();

  Future<int> countTotalIncome();

  Future<int> countTotalExpense();

  Future<void> insertSaving(SavingEntity saving);

  Future<List<SavingEntity>> loadSaving();

  Future<SavingEntity> loadSingleSaving(int id);

  Future<void> updateSavingBalance(int? savingId, int? balance);
}

class DuringRepositoryImpl extends DuringRepository {
  final DuringDbProvider _dbProvider;

  DuringRepositoryImpl(this._dbProvider);

  @override
  Future<void> saveTransaction(TransactionEntity transaction) =>
      _dbProvider.saveTransaction(transaction);

  @override
  Future<void> deleteTransaction(int? id) => _dbProvider.deleteTransaction(id);

  @override
  Future<List<TransactionEntity>> loadTodayTransaction() async {
    var result = await _dbProvider.loadDuringTransactions();
    if (result.isEmpty) {
      return result;
    } else {
      return result;
    }
  }

  @override
  Future<int> countTotalExpense() async {
    var result = await _dbProvider.totalExpense();
    if (result.isEmpty) {
      return 0;
    } else {
      return result.sum;
    }
  }

  @override
  Future<int> countTotalIncome() async {
    var result = await _dbProvider.totalIncome();
    if (result.isEmpty) {
      return 0;
    } else {
      return result.sum;
    }
  }

  @override
  Future<void> insertSaving(SavingEntity saving) =>
      _dbProvider.insertSaving(saving);

  @override
  Future<List<SavingEntity>> loadSaving() => _dbProvider.loadSavings();

  @override
  Future<SavingEntity> loadSingleSaving(int id) =>
      _dbProvider.loadSingleSaving(id);

  @override
  Future<void> updateSavingBalance(int? savingId, int? balance) =>
      _dbProvider.updateSavingBalance(savingId, balance);
}
