import 'package:flutter/material.dart';
import 'package:quizzler/QuizPage.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quizzler",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade800,
          title: Center(child: Text("Quizzler",style: TextStyle(fontWeight: FontWeight.bold),)),
        ),
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}


