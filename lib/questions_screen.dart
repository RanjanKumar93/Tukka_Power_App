import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tukka_power_app/answer_button.dart';
import 'package:tukka_power_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
    required this.onDoneQuizz,
  });

  final void Function(String answer) onSelectAnswer;
  final void Function() onDoneQuizz;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  late Timer _timer;
  double _timerProgress = 1.0;
  static const int _totalTimeInSeconds =
      25; // Total time for the quiz in seconds
  int _elapsedSeconds = 0;

  // State to store shuffled answers for the current question
  late List<String> _shuffledAnswers;

  @override
  void initState() {
    super.initState();
    startTimer();
    _shuffleAnswersForCurrentQuestion(); // Shuffle answers initially
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;

        // Calculate the timer progress
        _timerProgress = 1 - (_elapsedSeconds / _totalTimeInSeconds);

        if (_elapsedSeconds >= _totalTimeInSeconds) {
          _timer.cancel();
          widget.onDoneQuizz(); // End the quiz when time is up
        }
      });
    });
  }

  // Method to shuffle answers once for each question
  void _shuffleAnswersForCurrentQuestion() {
    final currentQuestion = questions[currentQuestionIndex];
    _shuffledAnswers = List.of(currentQuestion.answers); // Copy answers
    _shuffledAnswers.shuffle(); // Shuffle them once
  }

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);

    setState(() {
      currentQuestionIndex++;
      if (currentQuestionIndex < questions.length) {
        _shuffleAnswersForCurrentQuestion(); // Shuffle for the next question
      }
    });

    // If the user completes the quiz, stop the timer and end the quiz
    if (currentQuestionIndex >= questions.length) {
      _timer.cancel();
      widget.onDoneQuizz();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer progress indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Timer',
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: _timerProgress,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    currentQuestion.text,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // Use the shuffled answers stored in state
                  ..._shuffledAnswers.map((answer) {
                    return AnswerButton(
                      answerText: answer,
                      onTap: () {
                        answerQuestion(answer);
                      },
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.035),
            ElevatedButton(
              onPressed: widget.onDoneQuizz,
              child: const Text("End Quizz"),
            ),
            SizedBox(height: screenHeight * 0.035),
            // Progress for the number of questions
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.white24,
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
