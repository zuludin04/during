import 'package:during/data/source/entity/budget_entity.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';

abstract class DuringRepository {
  Future<int> saveTransaction(TransactionEntity transaction);

  Future<void> deleteTransaction(int? id);

  Future<void> updateTransaction(TransactionEntity transaction);

  Future<List<TransactionEntity>> loadTransactions();

  Future<List<TransactionEntity>> loadDailyTransactions(int start, int end);

  Future<List<TransactionEntity>> loadSavingTransactions(int savingId);

  Future<int> countTotalIncome(int start, int end);

  Future<int> countTotalExpense(int start, int end);

  Future<void> insertSaving(SavingEntity saving);

  Future<List<SavingEntity>> loadSaving();

  Future<int> loadTotalSavingBalance();

  Future<SavingEntity> loadSingleSaving(int id);

  Future<void> updateSavingBalance(int? savingId, int? balance);

  Future<void> updateSaving(SavingEntity saving);

  Future<List<TransactionEntity>> filterTransactions(
      String? range, String? type, String? category, String? saving);

  Future<void> deleteSaving(int? savingId);

  Future<void> deleteSavingTransactions(List<TransactionEntity> transactions);

  Future<void> initialCategory();

  Future<List<CategoryEntity>> loadCategoryType(int type);

  Future<List<CategoryEntity>> loadCategories();

  Future<void> inserteCategroy(CategoryEntity category);

  Future<void> deleteCategory(int? id);

  Future<void> updateCategory(CategoryEntity category);

  Future<CategoryEntity> loadSingleCategory(int categoryId);

  Future<void> addBudget(BudgetEntity budget);

  Future<void> updateBudget(BudgetEntity budget);

  Future<void> deleteBudget(int budgetId);

  Future<void> insertTransactionBudget(int transactionId, int budgetId);

  Future<List<BudgetEntity>> loadBudgets();

  Future<List<TransactionEntity>> loadBudgetTransactions(int budgetId);

  Future<void> resetAllData();
}
