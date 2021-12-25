import "dart:io";
import 'dart:async';
import 'package:expanse_manager/Model/Transaction.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:expanse_manager/Model/Transaction.dart' as txn;

class ExpenseDBHelper {
  static String expenseTbl = "expense_tbl";
  static final String columnId = "id";
  static final String columnTittle = "tittle";
  static final String columnAmount = "amount";
  static final String columnDate = "date";

  ExpenseDBHelper._privateConstructor();
  static final _expenseDBName = "expense.db";
  static final _expenseDBVersion = 1;

  static final ExpenseDBHelper instanceExpense =
      ExpenseDBHelper._privateConstructor();

  late Database _database;

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    //if (_database != null) return database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, _expenseDBName);

    return await openDatabase(path,
        version: _expenseDBVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    /*await db.execute('''CREATE TABLE $expenseTbl(
        $columnId INTEGER PRIMARY KEY,
        $columnTittle TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnDate TEXT NOT NULL,
      )''');*/

    await db.execute("CREATE TABLE  $expenseTbl ("
        "$columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "$columnTittle TEXT NOT NULL,"
        "$columnAmount REAL NOT NULL,"
        "$columnDate TEXT NOT NULL"
        ")");
  }

  // insert new expenses
  Future<int> insertIntoExpense(txn.TransactionModel element) async {
    Database db = await database;
    int id = await db.insert(expenseTbl, element.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // showing all expneses
  Future<List<Map<String, dynamic>>> getAllExpenses() async {
    Database db = await instanceExpense.database;
    var res = await db.query(expenseTbl);
    /*  if (res.length == 0) {
      return null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }*/
    return res;
  }

  // showing all expneses
  Future<List<TransactionModel>?> getAllExpensesList() async {
    Database db = await database;
    //List<Map<String, dynamic>> expensesList = await db.query(expenseTbl);
    var expensesList = await db.query(expenseTbl,
        columns: [columnId, columnTittle, columnAmount, columnDate]);
    /*  if (res.length == 0) {
      return null;
    } else {
      var resultMap = res.toList();TransactionModel
      return resultMap.isNotEmpty ? resultMap : Null;
    }*/
    // ignore: deprecated_member_use

    List<TransactionModel> dbTranscationList = [
      TransactionModel(id: 101, title: "Food", amount: 200, date: null),
    ];

    expensesList.forEach((element) {
      TransactionModel transactionModel = TransactionModel.fromMap(element);

      dbTranscationList.add(transactionModel);
    });

    return dbTranscationList;
  }

  Future<int> updateExpense(Map<String, dynamic> row) async {
    Database db = await instanceExpense.database;
    int id = row[columnId];
    return await db.update(expenseTbl, row,
        where: '$columnId= ?,$columnTittle = ?', whereArgs: [id]);
  }

  Future<int> deleteExpense(int id) async {
    Database db = await instanceExpense.database;
    return await db.delete(expenseTbl, where: '$columnId= ?', whereArgs: [id]);
  }

/*
   Future<TransactionModel> getTodo(int id) async {

    Database db = await instanceExpense.database;
    List<Map> maps = await db.query(expenseTbl,
        columns: [columnId, columnTittle, columnAmount,columnDate],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return TransactionModel.fromMap(maps.length);
    }
    return null;
  }*/
}
