import 'package:expanse_manager/widgets/AddTransaction.dart';
import 'package:expanse_manager/widgets/TransactionList.dart';
import 'package:expanse_manager/widgets/UserTransaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Database/expense_database_helper.dart';
import 'Model/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Manager"),
        actions: <Widget>[
          IconButton(
            onPressed: () => showBottomSheet(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //AddTransaction(onSaveItem),
          TransactionList(transcations, deleteTransaction),
          //UserTransaction(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(context),
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // function to pick date
  void _onDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _dateTime = value;
      });
    });
  }

  // function to save new data
  void onSaveItem(String title, double amount, DateTime dateTime) async {
    //final title = titleController.text;
    //var amount = double.parse(amountController.text);
    final newTranction =
        new TransactionModel(title: title, amount: amount, date: dateTime);
    //final newTranction2 = new Transaction.fromPlayer(title: title, amount: amount);

    int res =
        await ExpenseDBHelper.instanceExpense.insertIntoExpense(newTranction);
    print("Added Database ID: $res");
/*
    if (res != 0) {
    updateTransactionList();
    }*/

    setState(() {
      transcations.add(newTranction);
    });
  }
/*
  void onSave() {
    final title = titleController.text;
    //var amount = double.parse(amountController.text);
    if (titleController.text.isEmpty && _dateTime == null) {
      return;
    } else {
      onSaveItem("title", 40.00, _dateTime!);
    }
  }
  */

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: AddTransaction(onSaveItem),
          behavior: HitTestBehavior.opaque,
        );
      },
      /*builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AddTransaction(onSaveItem),
        ],
      ),*/
    );
  }

  // showContainer() {
  //   AddTransaction(onSaveItem);
  // }

  // delete item from list
  deleteTransaction(int id) {
    setState(() {
      transcations.removeWhere((element) => element.id == id);
    });
  }
}
