import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tukka_power_app/data/questions.dart';
import 'package:tukka_power_app/questions_screen.dart';
import 'package:tukka_power_app/results_screen.dart';
import 'package:tukka_power_app/start_screen.dart';

class Quizz extends StatefulWidget {
  const Quizz({super.key});

  @override
  State<Quizz> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  final List<String> _selectedAnswers = [];
  var _activeScreen = 'start-screen';
  Timer? _quizTimer;

  void _switchScreen() {
    setState(() {
      _activeScreen = 'questions-screen';
    });

    _quizTimer = Timer(const Duration(seconds: 25), () {
      onEndQuiz();
    });
  }

  void _chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      _quizTimer?.cancel();
      onEndQuiz();
    }
  }

  void restartQuiz() {
    setState(() {
      _selectedAnswers.clear();
      _activeScreen = 'questions-screen';
    });

    _quizTimer = Timer(const Duration(seconds: 25), () {
      onEndQuiz();
    });
  }

  void onEndQuiz() {
    setState(() {
      _activeScreen = 'results-screen';
    });
    _quizTimer?.cancel();
  }

  @override
  void dispose() {
    _quizTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(_switchScreen);

    if (_activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: _chooseAnswer,
        onDoneQuizz: onEndQuiz,
      );
    }

    if (_activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: _selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.pink,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
