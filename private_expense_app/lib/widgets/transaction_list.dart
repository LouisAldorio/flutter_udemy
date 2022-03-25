import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:private_expense_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) deleteTransaction;

  const TransactionList(
      {Key? key, required this.transactions, required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constaints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No Transactions added yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constaints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          "\$ ${transactions[index].amount.toStringAsFixed(2)}",
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          label: Text("Delete"),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                ),
              );
              // return Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         margin: EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 15,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).colorScheme.primary,
              //             width: 2,
              //           ),
              //         ),
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //           "\$ ${transactions[index].amount.toStringAsFixed(2)}",
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             color: Theme.of(context).colorScheme.primary,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             transactions[index].title,
              //             style: Theme.of(context).textTheme.headline6,
              //           ),
              //           Text(
              //             DateFormat.yMMMd().format(transactions[index].date),
              //             style: TextStyle(
              //               color: Colors.grey,
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
          );
  }
}
