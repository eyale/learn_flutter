import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_button.dart';

class TransactionsForm extends StatefulWidget {
  final Function onAddPress;

  TransactionsForm({required this.onAddPress}) {
    print('1. CONSTRUCTOR');
  }

  @override
  State<TransactionsForm> createState() {
      print('2. create State');
      return _TransactionsFormState();
    }
}

class _TransactionsFormState extends State<TransactionsForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _TransactionsFormState() {
    print('3. CONSTRUCTOR _TransactionsFormState');
  }

  @override
  void initState() {
    print('4. initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TransactionsForm oldWidget) {

    print('5. didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('6. dispose');
    super.dispose();
  }

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
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Platform.isIOS
                  ? CupertinoTextField(
                      controller: _titleController,
                      placeholder: 'Title',
                      onSubmitted: (_) => _onSubmit(),
                    )
                  : TextField(
                      controller: _titleController,
                      onSubmitted: (_) => _onSubmit(),
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
              Platform.isIOS
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CupertinoTextField(
                        controller: _amountController,
                        placeholder: 'Amount',
                        onSubmitted: (_) => _onSubmit,
                      ),
                    )
                  : TextField(
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
                    AdaptiveButton(onPress: _showDatePicker, title: 'Choose date',),
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
      ),
    );
  }
}
