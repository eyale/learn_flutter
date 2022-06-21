import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsItem extends StatefulWidget {
  const TransactionsItem({
    Key? key,
    required this.transaction,
    required this.removeTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeTransaction;

  @override
  State<TransactionsItem> createState() => _TransactionsItemState();
}

class _TransactionsItemState extends State<TransactionsItem> {
  late Color _avatarColor;
  @override
  void initState() {
    super.initState();

    const avatarColors = [
      Colors.amber,
      Colors.deepPurple,
      Colors.cyan,
      Colors.redAccent
    ];
    _avatarColor = avatarColors[Random().nextInt(avatarColors.length)];
  }

  void removeItem() {
    widget.removeTransaction(widget.transaction.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _avatarColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                   style: const TextStyle(color: Colors.white,),),
            ),
          ),
        ),
        title: Text(widget.transaction.title),
        subtitle: Text(
          DateFormat.yMMMMd('en_US')
              .add_Hm()
              .format(widget.transaction.date),
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
