import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) onAddTransaction;
  const NewTransaction({Key? key, required this.onAddTransaction})
      : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // String titleInput;
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.onAddTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate!,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            // handling keyboard open
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                onSubmitted: (_) => submitData(),
                // onChanged: (value) {
                //   titleInput = value;
                // },
                controller: titleController,
              ),
              TextField(
                style: TextStyle(
                  fontFamily: "Quicksand",
                ),
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // onChanged: (value) {
                //   amountInput = value;
                // },
                controller: amountController,
                onSubmitted: (_) => submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No Date Chosen"
                          : "Picked Date : ${DateFormat.yMd().format(_selectedDate!)}"),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              "Choose Date",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: _presentDatePicker)
                        : TextButton(
                            onPressed: _presentDatePicker,
                            child: Text(
                              "Choose Date",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                child: Text(
                  "Add Transaction",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
