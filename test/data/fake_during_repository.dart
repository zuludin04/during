import 'package:during/data/during_repository.dart';
import 'package:during/data/source/during_db_provider.dart';
import 'package:during/data/source/entity/budget_entity.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';

class FakeDuringRepository extends DuringRepository {
  final DuringDbProvider dbProvider;

  FakeDuringRepository(this.dbProvider);

  @override
  Future<void> addBudget(BudgetEntity budget) =>
      dbProvider.addBudgeting(budget);

  @override
  Future<int> countTotalExpense(int start, int end) async {
    var result = await dbProvider.totalExpense(start, end);
    return result;
  }

  @override
  Future<int> countTotalIncome(int start, int end) async {
    var result = await dbProvider.totalIncome(start, end);
    return result;
  }

  @override
  Future<void> deleteBudget(int budgetId) => dbProvider.deleteBudget(budgetId);

  @override
  Future<void> deleteCategory(int? id) => dbProvider.deleteCategory(id);

  @override
  Future<void> deleteSaving(int? savingId) => dbProvider.deleteSaving(savingId);

  @override
  Future<void> deleteSavingTransactions(List<TransactionEntity> transactions) =>
      dbProvider.deleteSavingTransactions(transactions);

  @override
  Future<void> deleteTransaction(int? id) => dbProvider.deleteTransaction(id);

  @override
  Future<List<TransactionEntity>> filterTransactions(
      String? range, String? type, String? category, String? saving) async {
    var query = '$range $type';
    var results = await dbProvider.filterTransactions(query);
    return results;
  }

  @override
  Future<void> initialCategory() => dbProvider.addInitialCategory();

  @override
  Future<void> insertSaving(SavingEntity saving) =>
      dbProvider.insertSaving(saving);

  @override
  Future<void> insertTransactionBudget(int transactionId, int budgetId) =>
      insertTransactionBudget(transactionId, budgetId);

  @override
  Future<void> inserteCategroy(CategoryEntity category) =>
      dbProvider.insertCategory(category);

  @override
  Future<List<TransactionEntity>> loadBudgetTransactions(int budgetId) async {
    var results = await dbProvider.loadBudgetTransactions(budgetId);
    return results;
  }

  @override
  Future<List<BudgetEntity>> loadBudgets() async {
    var results = await dbProvider.loadBudgets();
    return results;
  }

  @override
  Future<List<CategoryEntity>> loadCategories() async {
    var results = await dbProvider.loadCategories();
    return results;
  }

  @override
  Future<List<CategoryEntity>> loadCategoryType(int type) async {
    var results = await dbProvider.loadCategoryByType(type);
    return results;
  }

  @override
  Future<List<TransactionEntity>> loadDailyTransactions(
      int start, int end) async {
    var results = await dbProvider.loadDailyTransactions(start, end);
    return results;
  }

  @override
  Future<List<SavingEntity>> loadSaving() async {
    var results = await dbProvider.loadSavings();
    return results;
  }

  @override
  Future<List<TransactionEntity>> loadSavingTransactions(int savingId) async {
    var results = await dbProvider.loadSavingTransactions(savingId);
    return results;
  }

  @override
  Future<CategoryEntity> loadSingleCategory(int categoryId) async {
    var result = await dbProvider.loadSingleCategory(categoryId);
    return result;
  }

  @override
  Future<SavingEntity> loadSingleSaving(int id) async {
    var result = await dbProvider.loadSingleSaving(id);
    return result;
  }

  @override
  Future<List<TransactionEntity>> loadTransactions() async {
    var results = await dbProvider.loadDuringTransactions();
    return results;
  }

  @override
  Future<void> resetAllData() => dbProvider.deleteAllData();

  @override
  Future<int> saveTransaction(TransactionEntity transaction) =>
      dbProvider.saveTransaction(transaction);

  @override
  Future<void> updateBudget(BudgetEntity budget) =>
      dbProvider.updateBudget(budget);

  @override
  Future<void> updateCategory(CategoryEntity category) =>
      dbProvider.updateCategory(category);

  @override
  Future<void> updateSaving(SavingEntity saving) =>
      dbProvider.updateSaving(saving);

  @override
  Future<void> updateSavingBalance(int? savingId, int? balance) =>
      dbProvider.updateSavingBalance(savingId, balance);

  @override
  Future<void> updateTransaction(TransactionEntity transaction) =>
      dbProvider.updateTransaction(transaction);

  @override
  Future<int> loadTotalSavingBalance() => dbProvider.loadSavingBalance();
}
