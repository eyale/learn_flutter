import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsForm extends StatefulWidget {
  final Function onAddPress;

  const TransactionsForm({required this.onAddPress});

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _onSubmit() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) as double;

    final condition = title.isEmpty || amount.isNaN || amount <= 0;

    if (condition) {
      return;
    }

    widget.onAddPress(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              controller: _titleController,
              onSubmitted: (_) => _onSubmit(),
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => _onSubmit(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Choose transactions date please!'
                        : 'Picked date: ${DateFormat.yMMMMd('en_US').format(_selectedDate)}',
                  ),
                  OutlinedButton(
                    onPressed: _showDatePicker,
                    style: OutlinedButton.styleFrom(
                      primary: Theme.of(context).errorColor,
                      side: BorderSide(
                        color: Theme.of(context).errorColor,
                        width: 0.2,
                      ),
                    ),
                    child: const Text('Choose date'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                onPressed: _onSubmit,
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(color: Colors.yellow)))),
                child: const Text('Add new Transaction'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
