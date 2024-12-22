import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:x_tracker/app/modules/home/models/expense_model.dart';

final db = DatabaseHelper.instance;

class DatabaseHelper {
  static const _databaseName = 'expense_tracker.db';
  static const _databaseVersion = 1;

  static const table = 'expenses';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnAmount = 'amount';
  static const columnDescription = 'description';
  static const columnDate = 'date';
  static const columnTime = 'time';
  static const columnPaymentType = 'payment_type';
  static const columnPlace = 'place';
  static const columnNote = 'note';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the path to the database
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, _databaseName);

    // Open the database
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Create the table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnDescription TEXT,
        $columnDate TEXT NOT NULL,
        $columnTime TEXT NOT NULL,
        $columnPaymentType TEXT NOT NULL,
        $columnPlace TEXT NOT NULL,
        $columnNote TEXT
      )
    ''');
  }

  // Insert an Expense
  Future<int> insertExpense(Expense expense) async {
    Database db = await database;
    return await db.insert(table, expense.toMap());
  }

  // Get all Expenses
  Future<List<Expense>> getAllExpenses() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  // Get a specific Expense by ID
  Future<Expense?> getExpenseById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Expense.fromMap(maps.first);
    }
    return null;
  }

  // Update an Expense
  Future<int> updateExpense(Expense expense) async {
    Database db = await database;
    return await db.update(
      table,
      expense.toMap(),
      where: '$columnId = ?',
      whereArgs: [expense.id],
    );
  }

  // Delete an Expense
  Future<int> deleteExpense(int id) async {
    Database db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
