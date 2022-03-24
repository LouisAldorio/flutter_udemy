import 'package:flutter/material.dart';
import 'package:private_expense_app/models/transaction.dart';
import 'package:private_expense_app/widgets/chart.dart';
import 'package:private_expense_app/widgets/new_transaction.dart';
import 'package:private_expense_app/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        fontFamily: "Quicksand",
        // textTheme: ThemeData.light().textTheme.copyWith(
        //       headline6: TextStyle(
        //         fontFamily: "Quicksand",
        //         fontWeight: FontWeight.bold,
        //         fontSize: 18,
        //       ),
        //     ),
        // appBarTheme: AppBarTheme(
        //   // toolbarTextStyle: ThemeData.light()
        //   //     .textTheme
        //   //     .copyWith(
        //   //       titleLarge: TextStyle(
        //   //         fontFamily: "OpenSans",
        //   //         fontSize: 20,
        //   //         fontWeight: FontWeight.bold,
        //   //       ),
        //   //     )
        //   //     .bodyText2,
        //   titleTextStyle: ThemeData.light()
        //       .textTheme
        //       .copyWith(
        //         titleLarge: TextStyle(
        //             fontFamily: "OpenSans",
        //             fontSize: 20,
        //             fontWeight: FontWeight.bold),
        //       )
        //       .headline6,
        // ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceris",
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    setState(() {
      _userTransactions.add(
        Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date,
        ),
      );
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransaction(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(
          onAddTransaction: _addNewTransaction,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: [
          IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(recentTransactions: _recentTransactions),
          Expanded(
              child: TransactionList(
            transactions: _userTransactions,
            deleteTransaction: _deleteTransaction,
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
