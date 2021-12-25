import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  late Function addTranscation;

  AddTransaction(this.addTranscation);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _dateTime;
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: Column(children: <Widget>[
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: "Enter a title",
            ),
            keyboardType: TextInputType.text,
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: "Enter a Amount"),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(_dateTime == null
                    ? "No Date Choosen"
                    : "Pick a Date: ${DateFormat.yMd().format(_dateTime!)}"),
              ),
              TextButton(onPressed: _onDatePicker, child: Text("Choose Date")),
            ],
          ),
          TextButton(onPressed: onSave, child: Text("Save")),
        ]),
      ),
    );
  }

  // function to save new data
  void _onDatePicker() async {
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
/*
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime.now());
    setState(() {
      _dateTime = picked;
    });*/
  }

  // function to save new data
  void onSave() {
    final title = titleController.text;
    var amount = double.parse(amountController.text);
    // var amount1 = double.parse(amountController.text);

    if (titleController.text.isEmpty && amount <= 0 && _dateTime == null) {
      return;
    } else {
      widget.addTranscation(title, amount, _dateTime);
    }
    Navigator.of(context).pop();
  }
}
