import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './no_transactions.dart';
import './transactions_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: transactions.isEmpty
          ? const NoTransactions()
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionsItem(
                  transactions: transactions,
                  itemIndex: index,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
