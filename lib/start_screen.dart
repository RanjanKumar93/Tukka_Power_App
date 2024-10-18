import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to the Quizz Tukka!",
              style: GoogleFonts.ledger(
                color: Colors.white,
                fontSize: screenWidth * 0.09,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Answer 100 questions in 25 seconds\nCheck Your Tukka Power",
              style: GoogleFonts.ledger(
                color: Colors.white,
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton.icon(
              onPressed: startQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Quizz', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Benefits of using this app:",
              style: GoogleFonts.ledger(
                color: Colors.white,
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "• You will become a Tukka Hero!\n"
              "• Test how good you are at making guesses (Tukka)!\n",
              style: GoogleFonts.ledger(
                color: Colors.white,
                fontSize: screenWidth * 0.035,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
