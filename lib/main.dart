import 'package:flutter/material.dart';
import 'package:quizzler_app/quizzbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> ScoreKeeper = [];
  QuizzBrain quizzBrain = QuizzBrain();
  void checkpicker(bool userpickeranswer)
  {
    bool correctanswer = quizzBrain.getanswer();

    setState(() {

      if (quizzBrain.isfinished()==true)
        {
          Alert(context: context,title: 'Finished!',desc: 'You \'ve reached the end of the quiz.').show();
          quizzBrain.reset();
          ScoreKeeper=[];
        }
      else
        {
          if (userpickeranswer == correctanswer)
          {
            ScoreKeeper.add(Icon(Icons.check,color: Colors.green,));
          }
          else
          {
            ScoreKeeper.add(Icon(Icons.close,color: Colors.red,));
          }
          quizzBrain.nextquestion();
        }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizzBrain.getquestiontext(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            )),
        Expanded(
            child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            onPressed: () {
             checkpicker(true);
            },
            child: Center(
                child: Text(
              "True",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            onPressed: () {
              checkpicker(false);
            },
            child: Center(
                child: Text(
              "False",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
        )),
        Row(children: ScoreKeeper),
      ],
    );
  }
}
