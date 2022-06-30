import 'package:during/core/utils/constants.dart';
import 'package:during/data/source/entity/budget_entity.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DuringDbProvider {
  static DuringDbProvider? _duringDbProvider;

  DuringDbProvider._internal() {
    _duringDbProvider = this;
  }

  factory DuringDbProvider() =>
      _duringDbProvider ?? DuringDbProvider._internal();

  static late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'during.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE transaction(id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'type TEXT, '
        'date INTEGER, '
        'nominal INTEGER, '
        'categoryId INTEGER, '
        'name TEXT, '
        'color TEXT, '
        'savingId INTEGER, '
        'FOREIGN KEY (savingId) REFERENCES saving (id) ON DELETE NO ACTION ON UPDATE NO ACTION, '
        'FOREIGN KEY (categoryId) REFERENCES category (id) ON DELETE NO ACTION ON UPDATE NO ACTION)');
    // await db.execute(
    //     'CREATE TABLE transaction (id INTEGER PRIMARY KEY AUTOINCREMENT, '
    //     'type TEXT, '
    //     'date INTEGER, '
    //     'nominal INTEGER, '
    //     'category TEXT, '
    //     'name TEXT, '
    //     'color TEXT, '
    //     'savingId INTEGER)');

    await db.execute(
        'CREATE TABLE saving(id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'name TEXT, '
        'balance INTEGER, '
        'color TEXT, '
        'date INTEGER, '
        'categoryId INTEGER, '
        'FOREIGN KEY (categoryId) REFERENCES category (id) ON DELETE NO ACTION ON UPDATE NO ACTION)');
    // await db.execute(
    //     'CREATE TABLE saving (id INTEGER PRIMARY KEY AUTOINCREMENT, '
    //     'name TEXT, '
    //     'balance INTEGER, '
    //     'color TEXT, '
    //     'date INTEGER, '
    //     'category TEXT)');

    await db
        .execute('CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'name TEXT, '
            'icon TEXT, '
            'type INTEGER)');

    await db.execute(
        'CREATE TABLE budget (id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'name TEXT, '
        'color TEXT, '
        'icon TEXT, '
        'total INTEGER, '
        'percent INTEGER, '
        'used INTEGER, '
        'finishDate INTEGER, '
        'savingId, '
        'FOREIGN KEY (savingId) REFERENCES saving (id) ON DELETE NO ACTION ON UPDATE NO ACTION)');

    await db.execute(
        'CREATE TABLE transactionBudget (id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'transactionId INTEGER, '
        'budgetId INTEGER, '
        'FOREIGN KEY (transactionId) REFERENCES transaction (id) ON DELETE NO ACTION ON UPDATE NO ACTION, '
        'FOREIGN KEY (budgetId) REFERENCES budget (id) ON DELETE NO ACTION ON UPDATE NO ACTION)');
  }

  Future<void> saveTransaction(TransactionEntity transaction) async {
    final Database db = await database;
    await db.insert('transaction', transaction.toMap());
  }

  Future<void> deleteTransaction(int? id) async {
    final Database db = await database;
    await db.delete('transaction', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateTransaction(TransactionEntity transaction) async {
    final Database db = await database;
    await db.update('transaction', transaction.toMap(),
        where: 'id = ?', whereArgs: [transaction.id]);
  }

  Future<List<TransactionEntity>> loadDuringTransactions() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT category.name AS categoryName, category.icon AS categoryIcon, category.type AS categoryType, transaction.* '
        'FROM transaction INNER JOIN category '
        'ON transaction.categoryId = category.id '
        'ORDER BY transaction.id DESC');
    List<TransactionEntity> transactions = result.isEmpty
        ? []
        : result.map((e) => TransactionEntity.fromJoinDb(e)).toList();
    return transactions;
  }

  Future<List<TransactionEntity>> loadSavingTransactions(int savingId) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT category.name AS categoryName, category.icon AS categoryIcon, category.type AS categoryType, transaction.* '
        'FROM transaction INNER JOIN category '
        'ON transaction.categoryId = category.id '
        'WHERE transaction.savingId = $savingId');
    List<TransactionEntity> transactions = result.isEmpty
        ? []
        : result.map((e) => TransactionEntity.fromJoinDb(e)).toList();
    return transactions;
  }

  Future<List<int>> totalIncome() async {
    final Database db = await database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM transaction WHERE type = \'Income\'');
    List<int> incomes = result.isEmpty
        ? []
        : result.map((e) => TransactionEntity.fromMap(e).nominal!).toList();
    return incomes;
  }

  Future<List<int>> totalExpense() async {
    final Database db = await database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM transaction WHERE type = \'Expense\'');
    List<int> expenses = result.isEmpty
        ? []
        : result.map((e) => TransactionEntity.fromMap(e).nominal!).toList();
    return expenses;
  }

  Future<void> insertSaving(SavingEntity saving) async {
    final Database db = await database;
    await db.insert('saving', saving.toMap());
  }

  Future<List<SavingEntity>> loadSavings() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT category.name AS categoryName, category.icon AS categoryIcon, category.type AS categoryType, saving.* '
        'FROM saving, category '
        'WHERE saving.categoryId = category.id');
    List<SavingEntity> balance = result.isEmpty
        ? []
        : result.map((e) => SavingEntity.fromJoinDb(e)).toList();
    return balance;
  }

  Future<SavingEntity> loadSingleSaving(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM saving WHERE id = $id');
    List<SavingEntity> balance = result.isEmpty
        ? []
        : result.map((e) => SavingEntity.fromMap(e)).toList();
    if (balance.isNotEmpty) {
      return balance[0];
    } else {
      return SavingEntity();
    }
  }

  Future<void> updateSavingBalance(int? savingId, int? balance) async {
    final Database db = await database;
    await db.update('saving', {'balance': balance},
        where: 'id=?', whereArgs: [savingId]);
  }

  Future<List<TransactionEntity>> filterTransactions(String query) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery(query);
    List<TransactionEntity> transactions = results.isEmpty
        ? []
        : results.map((e) => TransactionEntity.fromJoinDb(e)).toList();
    return transactions;
  }

  Future<void> deleteSaving(int? id) async {
    final Database db = await database;
    await db.delete('saving', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteSavingTransactions(
      List<TransactionEntity> transactions) async {
    final Database db = await database;
    Batch batch = db.batch();

    for (var element in transactions) {
      batch.delete(
        'transaction',
        where: 'savingId = ?',
        whereArgs: [element.savingId],
      );
    }

    await batch.commit();
  }

  Future<void> addInitialCategory() async {
    final Database db = await database;
    Batch batch = db.batch();

    List<CategoryEntity> categories = initialCategories;
    for (var category in categories) {
      batch.insert('category', category.toMap());
    }

    await batch.commit();
  }

  Future<List<CategoryEntity>> loadCategories() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query('category');
    List<CategoryEntity> categories = result.isEmpty
        ? []
        : result.map((e) => CategoryEntity.fromMap(e)).toList();
    return categories;
  }

  Future<List<CategoryEntity>> loadCategoryByType(int type) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'category',
      where: 'type = ?',
      whereArgs: [type],
    );
    List<CategoryEntity> categories = result.isEmpty
        ? []
        : result.map((e) => CategoryEntity.fromMap(e)).toList();
    return categories;
  }

  Future<void> insertCategory(CategoryEntity category) async {
    final Database db = await database;
    await db.insert('category', category.toMap());
  }

  Future<void> deleteCategory(int? id) async {
    final Database db = await database;
    await db.delete('category', where: 'id = ?', whereArgs: [id]);
    await db.delete('transaction', where: 'categoryId = ?', whereArgs: [id]);
  }

  Future<void> updateCategory(CategoryEntity category) async {
    final Database db = await database;
    await db.update('category', category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  Future<void> addBudgeting(BudgetEntity budget) async {
    final Database db = await database;
    await db.insert('budget', budget.toMap());
  }

  // todo delete transaction, budget, transactionBudget rows
  Future<void> deleteBudget(int budgetId) async {
    final Database db = await database;
    await db.delete('budget', where: 'id = ?', whereArgs: [budgetId]);
  }

  Future<void> updateBudget(BudgetEntity budget) async {
    final Database db = await database;
    await db.update(
      'budget',
      budget.toMap(),
      where: 'id = ?',
      whereArgs: [budget.id],
    );
  }

  Future<void> insertTransactionBudget(int transactionId, int budgetId) async {
    final Database db = await database;
    await db.insert('transactionBudget', {
      'transactionId': transactionId,
      'budgetId': budgetId,
    });
  }

  Future<List<TransactionEntity>> loadBudgetTransactions(int budgetId) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.rawQuery('SELECT transaction.* '
            'FROM budgetTransaction '
            'INNER JOIN transaction '
            'ON budgetTransaction.transactionId = transaction.id '
            'INNER JOIN category '
            'ON transaction.categoryId = category.id '
            'WHERE budgetTransaction.budgetId = $budgetId');
    List<TransactionEntity> transactions = results.isEmpty
        ? []
        : results.map((e) => TransactionEntity.fromMap(e)).toList();
    return transactions;
  }
}
