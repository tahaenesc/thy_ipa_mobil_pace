import 'package:flutter/material.dart';
import '../../components/thy_header.dart';
import '../../core/theme.dart';

class DigitSpanResultScreen extends StatelessWidget {
  final List<int> answers;
  final List<int> correctSequence;
  final int questionIndex;
  final VoidCallback onNext;

  const DigitSpanResultScreen({
    super.key,
    required this.answers,
    required this.correctSequence,
    required this.questionIndex,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    bool isCorrect = _sequencesMatch();
    
    // Auto-advance after 5 seconds like in original Java app
    Future.delayed(const Duration(seconds: 5), () {
      onNext();
    });

    return Scaffold(
      body: Column(
        children: [
          ThyHeader(title: 'Practice ${questionIndex + 1} of 35'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your Answer:',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
                Text(
                  answers.isEmpty ? '-' : answers.join('-'),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Correct Answer:',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
                Text(
                  correctSequence.join('-'),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text(
              'Continuing in 5 seconds...',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  bool _sequencesMatch() {
    if (answers.length != correctSequence.length) return false;
    for (int i = 0; i < answers.length; i++) {
      if (answers[i] != correctSequence[i]) return false;
    }
    return true;
  }
}
