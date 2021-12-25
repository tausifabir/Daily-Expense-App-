import 'package:expanse_manager/Database/expense_database_helper.dart';
import 'package:expanse_manager/Model/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expanse_manager/Database/expense_database_helper.dart';

class TransactionList extends StatefulWidget {
  late List<TransactionModel> transactionList;
  Function deleteTransaction;
  TransactionList(this.transactionList, this.deleteTransaction);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  //List<TransactionModel> transactionList;
  /*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactionList2 = ExpenseDBHelper.instanceExpense.getAllExpensesList();
    print("Database List: $transactionList2");
  }*/

  @override
  Widget build(BuildContext context) {
    /*   return FutureBuilder(
        future: ExpenseDBHelper.instanceExpense.getAllExpensesList(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              var hello = snapshot.data.toString();

              return Card(
                child: Text(hello),
              );
            }
          } catch (ex) {
            return Card(
              child: Text(ex.toString()),
            );
          }
        });*/

    return Container(
        height: 300,
        child: widget.transactionList.isEmpty
            ? Center(child: Text("No Data"))
            : ListView.builder(
            itemCount: widget.transactionList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading:
                  Text(widget.transactionList[index].date.toString()),
                  // Text(transactionList2[index].title),
                  title: Text(widget.transactionList[index].title),
                  subtitle:
                  Text(widget.transactionList[index].amount.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () =>
                        widget.deleteTransaction(
                          widget.transactionList[index].id,
                        ),
                  ),
                ),
              );
            }));
  }
}
