import 'package:flutter/foundation.dart';
import 'package:send_money/data/models/response/transaction_history_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtils {
  static final DatabaseUtils _instance = DatabaseUtils._internal();
  static Database? _database;

  factory DatabaseUtils() {
    return _instance;
  }

  DatabaseUtils._internal();

  /// Getter for the database instance.
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize the database with required schema.
  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'my_database.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      throw Exception('Database initialization failed: $e');
    }
  }

  /// Create the `Transactions` table.
  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE Transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          transactionID TEXT, amount TEXT, createdAt TEXT
        )
      ''');
    } catch (e) {
      throw Exception('Table creation failed: $e');
    }
  }

  /// Retrieves all product IDs from the database as a list of strings.
  Future<List<TransactionData>> getTransactionMapList() async {
    final db = await database;
    try {
      final result = await db.query('transactions');
      debugPrint("AllTransactions => $result");
      return result.map((row) => TransactionData.fromMap(row)).toList();
    } catch (e) {
      throw Exception('Failed to fetch product IDs: $e');
    }
  }

  /*Future<int> insertTodoList(List<TransactionData> transactionList) async {
    final Database db = await instance.db;
    final Batch batch = db.batch();

    for (TransactionData transactionData in transactionList) {
      batch.insert('transactions', transactionData.toMap());
    }

    final List<dynamic> result = await batch.commit();
    final int affectedRows = result.reduce((sum, element) => sum + element);
    return affectedRows;
  }*/

  /// Inserts a product ID into the database.
  Future<void> insertTransactionList(List<TransactionData> transactionList) async {
    final db = await database;
    try {
      for (TransactionData transactionData in transactionList) {
        db.insert('transactions', transactionData.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    } catch (e) {
      throw Exception('Failed to insert product ID: $e');
    }
  }

  /// Clears all product IDs from the database.
  Future<void> clearDatabase() async {
    final db = await database;
    try {
      await db.delete('transactions');
    } catch (e) {
      throw Exception('Failed to clear transactions: $e');
    }
  }
}