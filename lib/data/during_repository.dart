import 'package:collection/collection.dart';
import 'package:during/data/source/during_db_provider.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';

abstract class DuringRepository {
  Future<void> saveTransaction(TransactionEntity transaction);

  Future<void> deleteTransaction(int? id);

  Future<void> updateTransaction(TransactionEntity transaction);

  Future<List<TransactionEntity>> loadTodayTransaction();

  Future<List<TransactionEntity>> loadSavingTransactions(int savingId);

  Future<int> countTotalIncome();

  Future<int> countTotalExpense();

  Future<void> insertSaving(SavingEntity saving);

  Future<List<SavingEntity>> loadSaving();

  Future<SavingEntity> loadSingleSaving(int id);

  Future<void> updateSavingBalance(int? savingId, int? balance);

  Future<List<TransactionEntity>> filterTransactions(
      String range, String? type, List<String>? category);

  Future<void> deleteSaving(int? savingId);
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
  Future<void> updateTransaction(TransactionEntity transaction) =>
      _dbProvider.updateTransaction(transaction);

  @override
  Future<List<TransactionEntity>> loadTodayTransaction() async {
    var result = await _dbProvider.loadDuringTransactions();
    return result;
  }

  @override
  Future<List<TransactionEntity>> loadSavingTransactions(int savingId) async {
    var result = await _dbProvider.loadSavingTransactions(savingId);
    return result;
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

  @override
  Future<List<TransactionEntity>> filterTransactions(
      String range, String? type, List<String>? category) async {
    var query = "SELECT * FROM duringTransaction WHERE date BETWEEN $range";

    if (type != null) {
      query = "$query AND type = '$type'";
    }

    if (category != null) {
      if (category.isNotEmpty) {
        query = "$query AND category IN (${_joinText(category)})";
      }
    }

    var results = await _dbProvider.filterTransactions(query);
    return results;
  }

  @override
  Future<void> deleteSaving(int? savingId) async {
    _dbProvider.deleteSaving(savingId);
  }

  String _joinText(List<String> values) {
    return "'${values.join("','")}'";
  }
}
