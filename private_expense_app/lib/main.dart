import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:private_expense_app/models/transaction.dart';
import 'package:private_expense_app/widgets/chart.dart';
import 'package:private_expense_app/widgets/new_transaction.dart';
import 'package:private_expense_app/widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
  bool _showChart = false;

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shoes",
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Weekly Groceris",
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Personal Expenses"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text("Personal Expenses"),
            actions: [
              IconButton(
                onPressed: () => startAddNewTransaction(context),
                icon: Icon(Icons.add),
              )
            ],
          )) as PreferredSizeWidget;

    final txListWidget = SizedBox(
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              appBar.preferredSize.height) *
          (isLandscape ? 0.8 : 0.7),
      child: TransactionList(
        transactions: _userTransactions,
        deleteTransaction: _deleteTransaction,
      ),
    );

    final pageBody = SafeArea(
      child: Column(
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Show Chart",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ],
            ),
          if (!isLandscape)
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appBar.preferredSize.height) *
                  0.3,
              child: Chart(recentTransactions: _recentTransactions),
            ),
          if (!isLandscape) txListWidget,
          if (isLandscape)
            _showChart
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            appBar.preferredSize.height) *
                        0.8,
                    child: Chart(recentTransactions: _recentTransactions),
                  )
                : txListWidget
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }
}
