import 'package:flutter/material.dart';
import 'dart:async';
import 'quiz_brain.dart';
import 'QuestionTypeSelectionPage.dart';

class QuizPage extends StatefulWidget {
  final String courseName;
  final QuizType quizType;

  const QuizPage({Key? key, required this.courseName, required this.quizType}) : super(key: key);

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  late QuizBrain quizBrain;
  List<Icon> scoreKeeper = [];
  int score = 0;
  bool isQuizStarted = false;
  int timer = 10;
  bool isAnswerSelected = false;
  bool? lastAnswerCorrect;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    quizBrain = QuizBrain(widget.courseName, widget.quizType);
  }

  void checkAnswer(String userAnswer) {
    var correctAnswer = quizBrain.getAnswer();
    setState(() {
      isAnswerSelected = true;
    });

    if (userAnswer == correctAnswer.toString()) {
      score++;
      scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      lastAnswerCorrect = true;
    } else {
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      lastAnswerCorrect = false;
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (quizBrain.isQuizFinished()) {
        showResult();
      } else {
        quizBrain.nextQuestion();
        startTimer();
        setState(() {
          isAnswerSelected = false;
        });
      }
    });
  }

  void startQuiz() {
    setState(() {
      isQuizStarted = true;
      score = 0;
      scoreKeeper.clear();
      startTimer();
    });
  }

  void startTimer() {
    countdownTimer?.cancel();
    timer = 10;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (this.timer > 0) {
          this.timer--;
        } else {
          checkAnswer('');
          countdownTimer?.cancel();
        }
      });
    });
  }

  void showResult() {
    countdownTimer?.cancel();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Quiz Completed!"),
          content: Text("Your score is $score/${quizBrain.getQuestionCount()}"),
          actions: [
            TextButton(
              child: const Text("Restart"),
              onPressed: () {
                setState(() {
                  quizBrain.reset();
                  scoreKeeper.clear();
                  score = 0;
                  timer = 10;
                  isQuizStarted = false;
                  isAnswerSelected = false;
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseName} Quiz'),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        shadowColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: isQuizStarted
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Time Left: $timer seconds',
              style: const TextStyle(fontSize: 20.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Text(
              quizBrain.getQuestion(),
              style: const TextStyle(
                  fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            if (quizBrain.isMultipleChoice())
              Expanded(
                child: ListView.builder(
                  itemCount: quizBrain.getOptions()!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAnswerSelected
                              ? (quizBrain.getAnswer() ==
                              quizBrain.getOptions()![index]
                              ? Colors.green
                              : Colors.red)
                              : Colors.deepPurple[50],
                          side: BorderSide(
                              color: Colors.deepPurple, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          shadowColor: Colors.deepPurpleAccent,
                        ),
                        child: Text(
                          quizBrain.getOptions()![index],
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.black87),
                        ),
                        onPressed: isAnswerSelected
                            ? null
                            : () =>
                            checkAnswer(quizBrain.getOptions()![index]),
                      ),
                    );
                  },
                ),
              )
            else
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAnswerSelected
                            ? (lastAnswerCorrect == true
                            ? Colors.green
                            : Colors.red)
                            : Colors.deepPurple[50],
                        side: BorderSide(
                            color: Colors.deepPurple, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        shadowColor: Colors.deepPurpleAccent,
                      ),
                      child: const Text('True',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.black87)),
                      onPressed: isAnswerSelected
                          ? null
                          : () => checkAnswer(true.toString()),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAnswerSelected
                            ? (lastAnswerCorrect == false
                            ? Colors.red
                            : Colors.green)
                            : Colors.deepPurple[50],
                        side: BorderSide(
                            color: Colors.deepPurple, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        shadowColor: Colors.deepPurpleAccent,
                      ),
                      child: const Text('False',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.black87)),
                      onPressed: isAnswerSelected
                          ? null
                          : () => checkAnswer(false.toString()),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20.0),
            Row(
              children: scoreKeeper,
            ),
          ],
        )
            : Center(
          child: ElevatedButton(
            onPressed: startQuiz,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 50.0, vertical: 20.0),
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: Colors.deepPurpleAccent,
            ),
            child: const Text(
              'Start Quiz',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
