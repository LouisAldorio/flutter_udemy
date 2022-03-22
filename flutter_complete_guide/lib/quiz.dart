import 'package:flutter/material.dart';
import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  const Quiz(
      {Key? key,
      required this.questionIndex,
      required this.questions,
      required this.answerQuestion})
      : super(key: key);

  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function(int) answerQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
            questionText: questions[questionIndex]["questionText"].toString()),
        ...(questions[questionIndex]["answers"] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            selectHandler: () => answerQuestion(answer["score"] as int),
            answerText: answer["text"].toString(),
          );
        }).toList(),
      ],
    );
  }
}
