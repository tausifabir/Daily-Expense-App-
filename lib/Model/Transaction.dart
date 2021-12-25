import 'package:expanse_manager/Database/expense_database_helper.dart';
import 'package:flutter_map/flutter_map.dart';

class TransactionModel {
  late int? id;
  late String title;
  late double amount;
  DateTime? date;

  TransactionModel(
      {this.id, required this.title, required this.amount, this.date});
/*
  TransactionModel.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.title = obj['tittle'];
    amount = obj['amount'];
    //date = obj['date'];
  }*/

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      ///'id': int.tryParse(id!),
      ExpenseDBHelper.columnTittle: title,
      ExpenseDBHelper.columnAmount: amount,
      ExpenseDBHelper.columnDate: date!.toIso8601String(),
    };
    if (id != null) {
      //map['id'] = int.tryParse(id!);
      map[ExpenseDBHelper.columnId] = id;
    }

    return map;
  }

  TransactionModel.fromMap(Map<String, dynamic> map) {
    id = map[ExpenseDBHelper.columnId];
    title = map[ExpenseDBHelper.columnTittle];
    amount = map[ExpenseDBHelper.columnAmount];
    //date = map[ExpenseDBHelper.columnDate];
  }
}
