import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transactions_form.dart';
import '../widgets/transactions_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: Card(
                    child: Text(
                      'Chart',
                      style: Theme.of(context).textTheme.headline1,
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
