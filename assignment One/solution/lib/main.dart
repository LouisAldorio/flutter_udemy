import 'package:flutter/material.dart';
import 'package:solution/text_control.dart';
import 'package:solution/text_output.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          appBar: AppBar(title: const Text('Assignment 1')),
          body: const TextControl()),
    );
  }
}
