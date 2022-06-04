import 'package:flutter/material.dart';

import './questionaire.dart';
import './questionaireResult.dart';

class Person {
  String name = 'Johnny';
  int age;

  void printProperties() {
    print('Persons name: ${name}, age: ${age}');
  }

  Person({this.name, this.age});

  Person.veryOld({this.age = 80});
}

void main() {
  // var mike = Person(name: 'Mike', age: 30);
  // mike.printProperties();

  Person mike = Person.veryOld(age: 70);
  mike.printProperties();
  print(mike.age);

  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State {
  var _questionIndex = 0;
  var _totalScore = 0;

  static const _questions = [
    {
      'question': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Yellow', 'score': 1},
        {'text': 'Red', 'score': 19},
        {'text': 'Green', 'score': 15},
        {'text': 'Blue', 'score': 10},
      ]
    },
    {
      'question': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Cat', 'score': 20},
        {'text': 'Dog', 'score': 14},
        {'text': 'Lizard', 'score': 32},
        {'text': 'Bunny', 'score': 44},
        {'text': 'Crocodile', 'score': 4}
      ]
    },
    {
      'question': 'What\'s your favorite car brand?',
      'answers': [
        {'text': 'Alfa Romeo', 'score': 50},
        {'text': 'BMW', 'score': 15},
        {'text': 'Audi', 'score': 20},
        {'text': 'Chery', 'score': 5}
      ]
    },
  ];

  void _handleChooseAnswer({int score}) {
    setState(() {
      _questionIndex += 1;
      _totalScore += score;
      print('_totalScore: ${_totalScore}');
    });
  }

  void resetQuestionaire() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(title: Text('FLUTTER APP')),
        body: _questions.length > _questionIndex
            ? Questionaire(
                questions: _questions,
                handlePress: _handleChooseAnswer,
                currentIdx: _questionIndex,
              )
            : QuestionaireResult(
                result: _totalScore,
                handleResetQuestionaire: resetQuestionaire,
              ),
      ),
    );
  }
}
