import 'package:flutter/material.dart';

import './button.dart';

class QuestionaireResult extends StatelessWidget {
  final int result;
  final Function handleResetQuestionaire;

  QuestionaireResult({this.result, this.handleResetQuestionaire});

  String get greetingsText {
    var text = '🎊Questionaire completed!🎊\n\n';
    var scoreText = 'Your score is: ${result}';
    if (this.result < 30) return text += 'Good result.🎉\n ${scoreText}';
    if (this.result < 50) return text += 'Wonderfull.🎉🎉🎉\n ${scoreText}';
    if (this.result < 70)
      return text += 'It is speachless.🎉🍀😶\n ${scoreText}';
    if (this.result < 100) return text += 'Awesome!🎉🔥💪\n ${scoreText}';
    if (this.result > 100) return text += 'You are ROCK!🎉🪨🍾\n ${scoreText}';

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
