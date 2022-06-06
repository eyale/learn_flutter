import 'package:flutter/material.dart';

import '../models/transaction.dart';

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: "1fkldf3371",
      title: "New Balance shop",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanse Planner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Card(
            color: Colors.blue,
            child: Text(
              'Chart',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Card(
            elevation: 5,
            color: Colors.redAccent,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'List of transactions',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
