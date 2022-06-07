import 'package:flutter/material.dart';

class TransactionsForm extends StatefulWidget {
  final Function onAddPress;

  const TransactionsForm({required this.onAddPress});

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmit() {
    final title = titleController.text;
    final amount = double.tryParse(amountController.text) as double;

    if (title.isEmpty || amount.isNaN || amount <= 0) {
      return;
    }

    widget.onAddPress(
      title,
      amount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => onSubmit(),
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => onSubmit(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: OutlinedButton(
                onPressed: onSubmit,
                style: OutlinedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  side: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.2,
                  ),
                ),
                child: const Text('Add new Transaction'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
