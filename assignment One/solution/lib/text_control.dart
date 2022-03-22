import 'package:flutter/material.dart';
import 'package:solution/text_output.dart';

class TextControl extends StatefulWidget {
  const TextControl({Key? key}) : super(key: key);

  @override
  State<TextControl> createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  String mainText = "This is the first assigment";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(
          onPressed: () {
            setState(() {
              mainText = "This changed!";
            });
          },
          child: const Text('Button'),
        ),
        TextOutput(mainText: mainText),
      ],
    );
  }
}
