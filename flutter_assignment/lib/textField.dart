import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // final VoidCallback<String>? onChangedText;
  final ValueChanged<String>? onChangedText;
  // final void Function(String)? onChangedText;
  // final Function? onChangedText;

  const CustomTextField({@required this.onChangedText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String text) {
        onChangedText!(text);
      },
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Type text to change ',
      ),
    );
  }
}
