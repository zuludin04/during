import 'package:during/data/during_repository.dart';
import 'package:during/data/source/during_db_provider.dart';
import 'package:during/data/source/entity/budget_entity.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';

class DuringRepositoryImpl extends DuringRepository {
  final DuringDbProvider _dbProvider;

  DuringRepositoryImpl(this._dbProvider);

  @override
  Future<int> saveTransaction(TransactionEntity transaction) =>
      _dbProvider.saveTransaction(transaction);

  @override
  Future<void> deleteTransaction(int? id) => _dbProvider.deleteTransaction(id);

  @override
  Future<void> updateTransaction(TransactionEntity transaction) =>
      _dbProvider.updateTransaction(transaction);

  @override
  Future<List<TransactionEntity>> loadTransactions() async {
    var result = await _dbProvider.loadDuringTransactions();
    return result;
  }

  @override
  Future<List<TransactionEntity>> loadDailyTransactions(int start, int end) =>
      _dbProvider.loadDailyTransactions(start, end);

  @override
  Future<List<TransactionEntity>> loadSavingTransactions(int savingId) async {
    var result = await _dbProvider.loadSavingTransactions(savingId);
    return result;
  }

  @override
  Future<int> countTotalExpense(int start, int end) async {
    var result = await _dbProvider.totalExpense(start, end);
    return result;
  }

  @override
  Future<int> countTotalIncome(int start, int end) async {
    var result = await _dbProvider.totalIncome(start, end);
    return result;
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
  Future<void> updateSaving(SavingEntity saving) =>
      _dbProvider.updateSaving(saving);

  @override
  Future<List<TransactionEntity>> filterTransactions(
      String? range, String? type, String? category, String? saving) async {
    var query =
        'SELECT category.name AS categoryName, category.icon AS categoryIcon, category.type AS categoryType, saving.color AS savingColor, transactionDuring.* '
        'FROM transactionDuring '
        'INNER JOIN category '
        'ON transactionDuring.categoryId = category.id '
        'INNER JOIN saving '
        'ON transactionDuring.savingId = saving.id';

    if (range != null) {
      query = '$query WHERE transactionDuring.date BETWEEN $range';
    }

    if (type != null) {
      query = "$query AND transactionDuring.type = '$type'";
    }

    if (saving != null) {
      query = "$query AND saving.name = '$saving'";
    }

    if (category != null) {
      query = "$query AND categoryName = '$category'";
    }

    query = "$query ORDER BY transactionDuring.date DESC";

    var results = await _dbProvider.filterTransactions(query);
    return results;
  }

  @override
  Future<void> deleteSaving(int? savingId) async {
    _dbProvider.deleteSaving(savingId);
  }

  @override
  Future<void> deleteSavingTransactions(
      List<TransactionEntity> transactions) async {
    await _dbProvider.deleteSavingTransactions(transactions);
  }

  @override
  Future<void> initialCategory() async {
    await _dbProvider.addInitialCategory();
  }

  @override
  Future<List<CategoryEntity>> loadCategoryType(int type) =>
      _dbProvider.loadCategoryByType(type);

  @override
  Future<List<CategoryEntity>> loadCategories() => _dbProvider.loadCategories();

  @override
  Future<void> deleteCategory(int? id) async {
    await _dbProvider.deleteCategory(id);
  }

  @override
  Future<void> inserteCategroy(CategoryEntity category) async {
    await _dbProvider.insertCategory(category);
  }

  @override
  Future<CategoryEntity> loadSingleCategory(int categoryId) =>
      _dbProvider.loadSingleCategory(categoryId);

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    await _dbProvider.updateCategory(category);
  }

  @override
  Future<void> addBudget(BudgetEntity budget) async {
    await _dbProvider.addBudgeting(budget);
  }

  @override
  Future<void> deleteBudget(int budgetId) async {
    await _dbProvider.deleteBudget(budgetId);
  }

  @override
  Future<void> insertTransactionBudget(int transactionId, int budgetId) async {
    await _dbProvider.insertTransactionBudget(transactionId, budgetId);
  }

  @override
  Future<List<BudgetEntity>> loadBudgets() => _dbProvider.loadBudgets();

  @override
  Future<List<TransactionEntity>> loadBudgetTransactions(int budgetId) =>
      _dbProvider.loadBudgetTransactions(budgetId);

  @override
  Future<void> updateBudget(BudgetEntity budget) async {
    await _dbProvider.updateBudget(budget);
  }

  @override
  Future<void> resetAllData() => _dbProvider.deleteAllData();

  @override
  Future<int> loadTotalSavingBalance() => _dbProvider.loadSavingBalance();
}