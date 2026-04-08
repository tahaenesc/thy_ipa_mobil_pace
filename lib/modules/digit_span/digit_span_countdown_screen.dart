import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme.dart';

class DigitSpanCountdownScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const DigitSpanCountdownScreen({super.key, required this.onComplete});

  @override
  State<DigitSpanCountdownScreen> createState() => _DigitSpanCountdownScreenState();
}

class _DigitSpanCountdownScreenState extends State<DigitSpanCountdownScreen> {
  int _counter = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 1) {
        setState(() {
          _counter--;
        });
      } else {
        _timer?.cancel();
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThyTheme.appBackground,
      body: Center(
        child: Text(
          '$_counter',
          style: const TextStyle(
            fontSize: 120,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
