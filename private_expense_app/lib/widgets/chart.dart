import 'package:flutter/material.dart';
import 'package:private_expense_app/models/transaction.dart';
import "package:intl/intl.dart";
import 'package:private_expense_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSum = 0.0;
        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 2),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + double.parse(element['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data["day"].toString(),
                  spendingAmount: data["amount"] as double,
                  spendingPctOfTotal: totalSpending == 0.0
                      ? 0.0
                      : ((data["amount"] as double) / totalSpending)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
