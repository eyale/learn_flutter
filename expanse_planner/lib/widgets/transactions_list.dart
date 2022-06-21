import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './no_transactions.dart';
import './transactions_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  const TransactionsList({
    Key? key,
    required this.transactions,
    required this.removeTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('💲💲💲 build TransactionList');
    return Container(
      color: Colors.blueGrey.shade100,
      child: SizedBox(
        child: transactions.isEmpty
            ? const NoTransactions()
            // : ListView.builder(
            //   // key: PageStorageKey(key),
            //     itemBuilder: (context, index) {
            //       return TransactionsItem(
            //           transaction: transactions[index],
            //           removeTransaction: removeTransaction);
            //     },
            //     itemCount: transactions.length,
            //   ),
            : ListView(children: transactions.map((transaction) => 
                TransactionsItem(
                      key: ValueKey(transaction.id),
                      transaction: transaction,
                      removeTransaction: removeTransaction)
            ).toList(),)
      ),
    );
  }
}
