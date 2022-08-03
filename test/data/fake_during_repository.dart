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
  Future<void> addBudget(BudgetEntity budget) {
    // TODO: implement addBudget
    throw UnimplementedError();
  }

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
  Future<void> deleteBudget(int budgetId) {
    // TODO: implement deleteBudget
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(int? id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSaving(int? savingId) {
    // TODO: implement deleteSaving
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSavingTransactions(List<TransactionEntity> transactions) {
    // TODO: implement deleteSavingTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(int? id) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionEntity>> filterTransactions(
      String range, String? type, List<String>? category) {
    // TODO: implement filterTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> initialCategory() {
    // TODO: implement initialCategory
    throw UnimplementedError();
  }

  @override
  Future<void> insertSaving(SavingEntity saving) {
    // TODO: implement insertSaving
    throw UnimplementedError();
  }

  @override
  Future<void> insertTransactionBudget(int transactionId, int budgetId) {
    // TODO: implement insertTransactionBudget
    throw UnimplementedError();
  }

  @override
  Future<void> inserteCategroy(CategoryEntity category) {
    // TODO: implement inserteCategroy
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionEntity>> loadBudgetTransactions(int budgetId) {
    // TODO: implement loadBudgetTransactions
    throw UnimplementedError();
  }

  @override
  Future<List<BudgetEntity>> loadBudgets() {
    // TODO: implement loadBudgets
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryEntity>> loadCategories() {
    // TODO: implement loadCategories
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryEntity>> loadCategoryType(int type) {
    // TODO: implement loadCategoryType
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionEntity>> loadDailyTransactions(int start, int end) {
    // TODO: implement loadDailyTransactions
    throw UnimplementedError();
  }

  @override
  Future<List<SavingEntity>> loadSaving() {
    // TODO: implement loadSaving
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionEntity>> loadSavingTransactions(int savingId) {
    // TODO: implement loadSavingTransactions
    throw UnimplementedError();
  }

  @override
  Future<CategoryEntity> loadSingleCategory(int categoryId) {
    // TODO: implement loadSingleCategory
    throw UnimplementedError();
  }

  @override
  Future<SavingEntity> loadSingleSaving(int id) {
    // TODO: implement loadSingleSaving
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionEntity>> loadTransactions() {
    // TODO: implement loadTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> resetAllData() {
    // TODO: implement resetAllData
    throw UnimplementedError();
  }

  @override
  Future<int> saveTransaction(TransactionEntity transaction) {
    // TODO: implement saveTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> updateBudget(BudgetEntity budget) {
    // TODO: implement updateBudget
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(CategoryEntity category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<void> updateSaving(SavingEntity saving) {
    // TODO: implement updateSaving
    throw UnimplementedError();
  }

  @override
  Future<void> updateSavingBalance(int? savingId, int? balance) {
    // TODO: implement updateSavingBalance
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
