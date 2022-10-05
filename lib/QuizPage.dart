import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int totalCorrectAnswer = 0;
  void checkAnswer(userAnswer){
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if(quizBrain.isFinished()){
        if(totalCorrectAnswer >quizBrain.totalQuestion()/2){
          Alert(
            context: context,
            type: AlertType.success,
            title: "Congratulations you win",
            desc: "You got $totalCorrectAnswer out of ${quizBrain.totalQuestion()}",
            buttons: [
              DialogButton(
                child: Text(
                  "Play Again",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }else{
          Alert(
            context: context,
            type: AlertType.error,
            title: "Oops you Failed!!",
            desc: "You got $totalCorrectAnswer out of ${quizBrain.totalQuestion()}",
            buttons: [
              DialogButton(
                child: Text(
                  "Play Again",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
        quizBrain.reset();
        scoreKeeper = [];
        totalCorrectAnswer = 0;
      }else {
        quizBrain.nextQuestion();
        if (correctAnswer == userAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
          totalCorrectAnswer++;
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child:QuestionDisplay(), //This component is write down into the below of this file
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

class QuestionDisplay extends StatelessWidget {
  const QuestionDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            quizBrain.getQuestionText(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}




