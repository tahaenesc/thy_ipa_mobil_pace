import 'package:flutter/material.dart';
import '../../components/intro_screen.dart';

class DigitSpanIntro2 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const DigitSpanIntro2({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      title: 'Example',
      children: [
        const Text(
          'If the following generated numbers are presented on the screen, one after the other, ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberedCircle('4'),
            const SizedBox(width: 15),
            _buildNumberedCircle('8'),
            const SizedBox(width: 15),
            _buildNumberedCircle('2', isKept: false),
            const SizedBox(width: 15),
            _buildNumberedCircle('5'),
          ],
        ),
        const SizedBox(height: 40),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(fontSize: 18, height: 1.5, color: Colors.black),
            children: [
              TextSpan(text: 'the string you should retrieve would be '),
              TextSpan(
                text: '4-8-5',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'To start with the practice trials, press the next button. You will be informed once the practice trials are over.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
      ],
      onNext: onNext,
      onBack: onBack,
    );
  }

  Widget _buildNumberedCircle(String number, {bool isKept = true}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isKept ? const Color(0xFFC55A11) : Colors.grey.shade300,
        shape: BoxShape.circle,
        border: Border.all(
          color: isKept ? Colors.black : Colors.grey.shade400,
          width: 3,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: TextStyle(
          fontSize: 28,
          color: isKept ? Colors.white : Colors.grey.shade600,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

