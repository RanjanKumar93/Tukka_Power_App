import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tukka_power_app/data/questions.dart';
import 'package:tukka_power_app/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = questions.length;
    final correctAnswers = summaryData
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Quiz Completed!',
            style: GoogleFonts.oregano(
              color: Colors.white,
              fontSize: screenWidth * 0.09,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'You got $correctAnswers out of $totalQuestions correct!',
            style: GoogleFonts.oregano(
              color: Colors.white,
              fontSize: screenWidth * 0.045,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Your Tukka Power out of 10 : ${(correctAnswers / totalQuestions * 10).toStringAsFixed(2)}',
            style: GoogleFonts.oregano(
              color: Colors.white,
              fontSize: screenWidth * 0.055,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.03),
          QuestionsSummary(summaryData),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: ElevatedButton.icon(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.04),
              ),
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: Text('Restart Quiz',
                  style: TextStyle(
                      fontSize: screenWidth * 0.05, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
