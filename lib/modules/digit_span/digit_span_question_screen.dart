import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'digit_span_service.dart';

class DigitSpanQuestionScreen extends StatefulWidget {
  final DigitSequence sequence;
  final VoidCallback onComplete;

  const DigitSpanQuestionScreen({
    super.key,
    required this.sequence,
    required this.onComplete,
  });

  @override
  State<DigitSpanQuestionScreen> createState() => _DigitSpanQuestionScreenState();
}

class _DigitSpanQuestionScreenState extends State<DigitSpanQuestionScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);

    _startSequence();
  }

  void _startSequence() async {
    for (int i = 0; i < widget.sequence.numbers.length; i++) {
      if (!mounted) return;
      
      setState(() {
        _currentIndex = i;
      });
      
      _fadeController.reset();
      await _fadeController.forward();
      // Brief pause between numbers as seen in AnimationUtils.pause(1000)
      await Future.delayed(const Duration(milliseconds: 500));
    }
    
    widget.onComplete();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThyTheme.appBackground,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            '${widget.sequence.numbers[_currentIndex]}',
            style: const TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
