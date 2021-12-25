import 'package:expanse_manager/Model/Transaction.dart';
import 'package:flutter/material.dart';

import 'AddTransaction.dart';
import 'TransactionList.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _dateTime;
  List<TransactionModel> transcations = [
    TransactionModel(id: 101, title: "Food", amount: 200, date: null),
    TransactionModel(
        id: 102, title: "Shopping", amount: 600, date: DateTime.now()),
    TransactionModel(id: 103, title: "Transport", amount: 1550, date: null),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AddTransaction(onSaveItem),
        TransactionList(transcations, deleteTransaction),
      ],
    );
  }

  // delete item from list
  deleteTransaction(String id) {
    setState(() {
      transcations.removeWhere((element) => element.id == id);
    });
  }

  // function to save new data
  void onSaveItem(String title, double amount, DateTime dateTime) {
    final title = titleController.text;
    //var amount = double.parse(amountController.text);
    final newTranction = new TransactionModel(
        id: 105, title: "title", amount: amount, date: dateTime);

    setState(() {
      transcations.add(newTranction);
    });
  }
}
