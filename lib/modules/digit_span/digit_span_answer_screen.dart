import 'package:flutter/material.dart';
import '../../components/thy_header.dart';
import '../../core/theme.dart';

class DigitSpanAnswerScreen extends StatefulWidget {
  final int expectedLength;
  final Function(List<int>) onSubmited;

  const DigitSpanAnswerScreen({
    super.key,
    required this.expectedLength,
    required this.onSubmited,
  });

  @override
  State<DigitSpanAnswerScreen> createState() => _DigitSpanAnswerScreenState();
}

class _DigitSpanAnswerScreenState extends State<DigitSpanAnswerScreen> {
  final List<int> _enteredDigits = [];

  void _onNumberPressed(int number) {
    if (_enteredDigits.length < widget.expectedLength) {
      setState(() {
        _enteredDigits.add(number);
      });
      if (_enteredDigits.length == widget.expectedLength) {
        // Auto submit if length reached OR wait for a button? 
        // Original app seems to just let user enter.
        Future.delayed(const Duration(milliseconds: 500), () {
          widget.onSubmited(_enteredDigits);
        });
      }
    }
  }

  void _onBackspace() {
    if (_enteredDigits.isNotEmpty) {
      setState(() {
        _enteredDigits.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ThyHeader(title: 'Practice'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _enteredDigits.join(' '),
                  style: const TextStyle(fontSize: 48, letterSpacing: 8),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 400,
                  height: 2,
                  color: ThyTheme.accentRed,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 350,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.5,
                    children: [
                      for (int i = 1; i <= 9; i++) _buildKeypadButton(i),
                      const SizedBox.shrink(),
                      _buildKeypadButton(0),
                      _buildKeypadButton(-1, isBackspace: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(int value, {bool isBackspace = false}) {
    return ElevatedButton(
      onPressed: isBackspace ? _onBackspace : () => _onNumberPressed(value),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Match LIGHTGRAY background? No, buttons are white-ish in FXML
        foregroundColor: Colors.black,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Text(
        isBackspace ? '⌫' : '$value',
        style: const TextStyle(fontSize: 32),
      ),
    );
  }
}
