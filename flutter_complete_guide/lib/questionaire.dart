import 'package:flutter/material.dart';

import './button.dart';
import './question.dart';

class Questionaire extends StatelessWidget {
  List<Map<String, Object>> questions;
  Function handlePress;
  int currentIdx;

  Questionaire({
    @required this.questions,
    @required this.handlePress,
    @required this.currentIdx,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(text: questions[currentIdx]['question']),
        ...(questions[currentIdx]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return CustomButton(
            title: answer['text'],
            handlePress: () => handlePress(score: answer['score']),
          );
        }).toList(),
      ],
    );
  }
}
