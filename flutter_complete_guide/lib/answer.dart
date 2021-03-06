import 'package:flutter/material.dart';

@immutable
class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  const Answer({Key? key, required this.selectHandler, required this.answerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}
