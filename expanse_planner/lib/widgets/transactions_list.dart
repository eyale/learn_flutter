import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './no_transactions.dart';
import './transactions_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  Function removeTransaction;

  TransactionsList({
    required this.transactions,
    required this.removeTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade100,
      child: SizedBox(
        child: transactions.isEmpty
            ? const NoTransactions()
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionsItem(
                      transactions: transactions,
                      itemIndex: index,
                      removeTransaction: removeTransaction);
                },
                itemCount: transactions.length,
              ),
      ),
    );
  }
}
