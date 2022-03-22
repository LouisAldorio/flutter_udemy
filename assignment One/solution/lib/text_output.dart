import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  const TextOutput({Key? key, required this.mainText}) : super(key: key);

  final String mainText;

  @override
  Widget build(BuildContext context) {
    return Text(mainText);
  }
}
