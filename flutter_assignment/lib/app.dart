/*
*
Create a new Flutter App (flutter create flutter_assignment, then replace your main.dart with the attached one) and output an AppBar and some text below it (i.e. in the body of the page)

Add a button (e.g. RaisedButton) which changes the text (to any other text of your choice)

Split the app into three custom widgets: App, TextControl & Text
 */
import 'package:flutter/material.dart';
import './button.dart';
import './textField.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _text = 'SOME TEST TEXT';
  var _storedText = 'asdas';

  void _handleApplyText() {
    setState(() {
      _text = _storedText;
    });
  }

  void _onChangeTextField(text) {
    setState(() {
      _storedText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: const Text('flutter_assignment')),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.all(40),
            child: Text(
              _text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomTextField(
              onChangedText: _onChangeTextField,
            ),
          ),
          CustomButton(onPressed: _handleApplyText),
        ]),
      ),
    );
  }
}
