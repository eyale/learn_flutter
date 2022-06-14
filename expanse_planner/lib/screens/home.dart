import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transactions_form.dart';
import '../widgets/transactions_list.dart';
import '../widgets/chart.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final Transaction newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
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

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Expanse Planner'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _showBottomShit(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          onPressed: () => _showBottomShit(context),
          icon: const Icon(Icons.add),
        ),
        onPressed: () => _showBottomShit(context),
      ),
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(recentTransactions: _recentTransactions),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: TransactionsList(
                      transactions: _transactions,
                      removeTransaction: _removeTransaction),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
