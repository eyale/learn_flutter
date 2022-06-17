import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsItem extends StatelessWidget {
  const TransactionsItem({
    Key? key,
      required this.transactions,
      required this.itemIndex,
      required this.removeTransaction,
    })
      : super(key: key);

  final List<Transaction> transactions;
  final int itemIndex;
  final Function removeTransaction;

  void removeItem() {
    removeTransaction(transactions[itemIndex].id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                  '\$${transactions[itemIndex].amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(transactions[itemIndex].title),
        subtitle: Text(
          DateFormat.yMMMMd('en_US')
              .add_Hm()
              .format(transactions[itemIndex].date),
          style: const TextStyle(fontSize: 13),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).errorColor),
                onPressed: removeItem,
                icon: const Icon(
                  Icons.delete,
                ),
                label: Text(
                  'Delete item',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: removeItem,
              ),
      ),
    );
  }
}
