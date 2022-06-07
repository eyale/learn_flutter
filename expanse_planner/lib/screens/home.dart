import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transactions_form.dart';
import '../widgets/transactions_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1fkldf3371',
      title: 'New Balance shop',
      amount: 33.02,
      date: DateTime.now(),
    ),
    Transaction(
      id: '312opie233',
      title: 'Silpo shop',
      amount: 70.0,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, double amount) {
    final Transaction newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _showBottomShit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionsForm(onAddPress: _addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          onPressed: () => _showBottomShit(context),
          icon: const Icon(Icons.add),
        ),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: const Text('Expanse Planner'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _showBottomShit(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Chart',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                TransactionsList(transactions: _transactions),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
