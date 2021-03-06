import 'package:flutter/material.dart';

import './button.dart';

class QuestionaireResult extends StatelessWidget {
  final int result;
  final Function handleResetQuestionaire;

  QuestionaireResult({this.result, this.handleResetQuestionaire});

  String get greetingsText {
    var text = 'πQuestionaire completed!π\n\n';
    var scoreText = 'Your score is: ${result}';
    if (this.result < 30) return text += 'Good result.π\n ${scoreText}';
    if (this.result < 50) return text += 'Wonderfull.πππ\n ${scoreText}';
    if (this.result < 70)
      return text += 'It is speachless.πππΆ\n ${scoreText}';
    if (this.result < 100) return text += 'Awesome!ππ₯πͺ\n ${scoreText}';
    if (this.result > 100) return text += 'You are ROCK!ππͺ¨πΎ\n ${scoreText}';

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Text(
        greetingsText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      CustomButton(
        title: 'Retake the quiestionaire',
        handlePress: handleResetQuestionaire,
        backgroundColor: Colors.deepOrange,
      )
    ]));
  }
}
