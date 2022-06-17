import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  Chart({required this.recentTransactions}) {
    print('constructor chart'.toUpperCase());
  }

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0.0;
      for (var transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          sum += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': sum,
      };
    });
  }

  double get weekAmount {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('💹 build Chart');
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactionValues.reversed.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: e['day'] as String,
                  amount: e['amount'] as double,
                  percentFromTotal: weekAmount == 0.0
                      ? 0.0
                      : (e['amount'] as double) / weekAmount,
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
