import 'package:during/core/utils/constants.dart';
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
    await db.execute("""
        CREATE TABLE duringTransaction(id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        date INTEGER,
        nominal INTEGER,
        categoryId INTEGER,
        name TEXT,
        color TEXT,
        savingId INTEGER,
        FOREIGN KEY (categoryId) REFERENCES duringCategory (id) ON DELETE NO ACTION ON UPDATE NO ACTION
        )
        """);
    // await db.execute(
    //     'CREATE TABLE duringTransaction (id INTEGER PRIMARY KEY AUTOINCREMENT, '
    //     'type TEXT, '
    //     'date INTEGER, '
    //     'nominal INTEGER, '
    //     'category TEXT, '
    //     'name TEXT, '
    //     'color TEXT, '
    //     'savingId INTEGER)');

    await db.execute("""
        CREATE TABLE duringSaving(id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        balance INTEGER,
        color TEXT,
        date INTEGER,
        categoryId INTEGER,
        FOREIGN KEY (categoryId) REFERENCES duringCategory (id) ON DELETE NO ACTION ON UPDATE NO ACTION
        )
        """);
    // await db.execute(
    //     'CREATE TABLE duringSaving (id INTEGER PRIMARY KEY AUTOINCREMENT, '
    //     'name TEXT, '
    //     'balance INTEGER, '
    //     'color TEXT, '
    //     'date INTEGER, '
    //     'category TEXT)');

    await db.execute(
        'CREATE TABLE duringCategory (id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'name TEXT, '
        'icon TEXT, '
        'type INTEGER)');
  }

  Future<void> saveTransaction(TransactionEntity transaction) async {
    final Database db = await database;
    await db.insert('duringTransaction', transaction.toMap());
  }

  Future<void> deleteTransaction(int? id) async {
    final Database db = await database;
    await db.delete('duringTransaction', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateTransaction(TransactionEntity transaction) async {
    final Database db = await database;
    await db.update('duringTransaction', transaction.toMap(),
        where: 'id = ?', whereArgs: [transaction.id]);
  }

  Future<List<TransactionEntity>> loadDuringTransactions() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT duringCategory.name AS categoryName, duringCategory.icon AS categoryIcon, duringCategory.type AS categoryType, duringTransaction.* '
        'FROM duringTransaction INNER JOIN duringCategory '
        'ON duringTransaction.categoryId = duringCategory.id '
        'ORDER BY duringTransaction.id DESC');
    List<TransactionEntity> transactions = result.isEmpty
        ? []
        : result.map((e) => TransactionEntity.fromJoinDb(e)).toList();
    return transactions;
  }

  Future<List<TransactionEntity>> loadSavingTransactions(int savingId) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT duringCategory.name AS categoryName, duringCategory.icon AS categoryIcon, duringCategory.type AS categoryType, duringTransaction.* '
        'FROM duringTransaction INNER JOIN duringCategory '
        'ON duringTransaction.categoryId = duringCategory.id '
        'WHERE duringTransaction.savingId = $savingId');
    List<TransactionEntity> transactions = result.isEmpty
        ? []
        : result.map((e) => TransactionEntity.fromJoinDb(e)).toList();
    return transactions;
  }

  Future<List<int>> totalIncome() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT * FROM duringTransaction WHERE type = \'Income\'');
    List<int> incomes = result.isEmpty
        ? []
        : result.map((e) => TransactionEntity.fromMap(e).nominal!).toList();
    return incomes;
  }

  Future<List<int>> totalExpense() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT * FROM duringTransaction WHERE type = \'Expense\'');
    List<int> expenses = result.isEmpty
        ? []
        : result.map((e) => TransactionEntity.fromMap(e).nominal!).toList();
    return expenses;
  }

  Future<void> insertSaving(SavingEntity saving) async {
    final Database db = await database;
    await db.insert('duringSaving', saving.toMap());
  }

  Future<List<SavingEntity>> loadSavings() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT duringCategory.name AS categoryName, duringCategory.icon AS categoryIcon, duringCategory.type AS categoryType, duringSaving.* '
        'FROM duringSaving, duringCategory '
        'WHERE duringSaving.categoryId = duringCategory.id');
    List<SavingEntity> balance = result.isEmpty
        ? []
        : result.map((e) => SavingEntity.fromJoinDb(e)).toList();
    return balance;
  }

  Future<SavingEntity> loadSingleSaving(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM duringSaving WHERE id = $id');
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
    await db.update('duringSaving', {'balance': balance},
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
    await db.delete('duringSaving', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteSavingTransactions(
      List<TransactionEntity> transactions) async {
    final Database db = await database;
    Batch batch = db.batch();

    for (var element in transactions) {
      batch.delete(
        'duringTransaction',
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
      batch.insert('duringCategory', category.toMap());
    }

    await batch.commit();
  }

  Future<List<CategoryEntity>> loadCategoryByType(int type) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'duringCategory',
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
    await db.insert('duringCategory', category.toMap());
  }

  Future<void> deleteCategory(int? id) async {
    final Database db = await database;
    await db.delete('duringCategory', where: 'id = ?', whereArgs: [id]);
    await db
        .delete('duringTransaction', where: 'categoryId = ?', whereArgs: [id]);
  }

  Future<void> updateCategory(CategoryEntity category) async {
    final Database db = await database;
    await db.update('duringCategory', category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
  }
}
