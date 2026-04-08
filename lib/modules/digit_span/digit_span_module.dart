import 'package:flutter/material.dart';
import 'digit_span_intro_1.dart';
import 'digit_span_intro_2.dart';
import 'digit_span_countdown_screen.dart';
import 'digit_span_question_screen.dart';
import 'digit_span_answer_screen.dart';
import 'digit_span_result_screen.dart';
import 'digit_span_service.dart';

enum DigitSpanStep {
  intro1,
  intro2,
  countdown,
  question,
  answer,
  result,
}

class DigitSpanModule extends StatefulWidget {
  const DigitSpanModule({super.key});

  @override
  State<DigitSpanModule> createState() => _DigitSpanModuleState();
}

class _DigitSpanModuleState extends State<DigitSpanModule> {
  DigitSpanStep _currentStep = DigitSpanStep.intro1;
  int _currentQuestionIndex = 0;
  List<int> _lastAnswers = [];

  void _previousStep() {
    setState(() {
      switch (_currentStep) {
        case DigitSpanStep.intro2:
          _currentStep = DigitSpanStep.intro1;
          break;
        case DigitSpanStep.countdown:
          _currentStep = DigitSpanStep.intro2;
          break;
        default:
          break;
      }
    });
  }

  void _nextStep() {
    setState(() {
      switch (_currentStep) {
        case DigitSpanStep.intro1:
          _currentStep = DigitSpanStep.intro2;
          break;
        case DigitSpanStep.intro2:
          _currentStep = DigitSpanStep.countdown;
          break;
        case DigitSpanStep.countdown:
          _currentStep = DigitSpanStep.question;
          break;
        case DigitSpanStep.question:
          _currentStep = DigitSpanStep.answer;
          break;
        case DigitSpanStep.answer:
          _currentStep = DigitSpanStep.result;
          break;
        case DigitSpanStep.result:
          if (_currentQuestionIndex < 34) {
            _currentQuestionIndex++;
            _currentStep = DigitSpanStep.countdown;
          } else {
            Navigator.pop(context);
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentStep) {
      case DigitSpanStep.intro1:
        return DigitSpanIntro1(
          onNext: _nextStep,
          onBack: () => Navigator.pop(context),
        );
      case DigitSpanStep.intro2:
        return DigitSpanIntro2(
          onNext: _nextStep,
          onBack: _previousStep,
        );
      case DigitSpanStep.countdown:
        return DigitSpanCountdownScreen(onComplete: _nextStep);
      case DigitSpanStep.question:
        return DigitSpanQuestionScreen(
          sequence: DigitSpanService.getSequence(_currentQuestionIndex),
          onComplete: _nextStep,
        );
      case DigitSpanStep.answer:
        final sequence = DigitSpanService.getSequence(_currentQuestionIndex);
        return DigitSpanAnswerScreen(
          expectedLength: sequence.numbers.length, 
          onSubmited: (answers) {
            _lastAnswers = answers;
            _nextStep();
          },
        );
      case DigitSpanStep.result:
        final sequence = DigitSpanService.getSequence(_currentQuestionIndex);
        return DigitSpanResultScreen(
          answers: _lastAnswers,
          correctSequence: sequence.targetSequence,
          questionIndex: _currentQuestionIndex,
          onNext: _nextStep,
        );
    }
  }
}
