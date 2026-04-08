import 'package:flutter/material.dart';
import 'sustained_attention_intro.dart';
import 'sustained_attention_test_screen.dart';

class SustainedAttentionModule extends StatefulWidget {
  const SustainedAttentionModule({super.key});

  @override
  State<SustainedAttentionModule> createState() => _SustainedAttentionModuleState();
}

class _SustainedAttentionModuleState extends State<SustainedAttentionModule> {
  bool _isTestStarted = false;
  bool _isPractice = true;

  void _startPractice() {
    setState(() {
      _isTestStarted = true;
      _isPractice = true;
    });
  }

  void _startTest() {
    setState(() {
      _isTestStarted = true;
      _isPractice = false;
    });
  }

  void _onFinish() {
    if (_isPractice) {
      // After practice, show a screen to start the real test
      setState(() {
        _isTestStarted = false;
        _isPractice = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isTestStarted) {
      return SustainedAttentionTestScreen(
        isPractice: _isPractice,
        onFinish: _onFinish,
      );
    }

    return SustainedAttentionIntro(
      onNext: _isPractice ? _startPractice : _startTest,
      onBack: () => Navigator.pop(context),
      isStartOfTest: !_isPractice,
    );
  }
}
