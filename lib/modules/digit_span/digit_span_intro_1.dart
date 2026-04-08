import 'package:flutter/material.dart';
import '../../components/intro_screen.dart';

class DigitSpanIntro1 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const DigitSpanIntro1({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      title: 'Verbal Memory Test',
      children: const [
        Text(
          'In this task, generated numbers will appear in a sequence, one after the other. Each number stays on the screen for 1 second and is then replaced by the next one. Your first task is to compare each number with the one before it, except for the first number shown. Remember the initial number of each set and any generated numbers greater than the previous one. ',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
        SizedBox(height: 20),
        Text(
          'When the response window opens, you\'ll need to tap the generated numbers on the digital keypad in the order you saw them. The keypad will be on the screen for a limited time, so tap your responses quickly. After the time is up, a new sequence will be presented.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
      ],
      onNext: onNext,
      onBack: onBack,
    );
  }
}
