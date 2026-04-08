import 'package:flutter/material.dart';
import 'avm_level_selection.dart';
import 'audio_visual_memory_intro.dart';
import 'avm_test_screen.dart';
import 'avm_response_screen.dart';

enum AVMStep {
  levelSelection,
  introText,
  introComparison,
  testPhase,
  responseWindow,
}

class AudioVisualMemoryModule extends StatefulWidget {
  const AudioVisualMemoryModule({super.key});

  @override
  State<AudioVisualMemoryModule> createState() => _AudioVisualMemoryModuleState();
}

class _AudioVisualMemoryModuleState extends State<AudioVisualMemoryModule> {
  AVMStep _currentStep = AVMStep.levelSelection;
  String _selectedLevel = 'EASY';
  int _currentPractice = 1;
  static const int _totalPractices = 30;
  List<int> _occupiedCorridors = [];
  List<Map<String, dynamic>> _testSequence = [];

  void _onLevelSelected(String level) {
    setState(() {
      _selectedLevel = level;
      _currentStep = AVMStep.introText;
    });
  }

  void _startNextPractice() {
    if (_currentPractice < _totalPractices) {
      setState(() {
        _currentPractice++;
        _currentStep = AVMStep.testPhase;
      });
    } else {
      // Completed all 30 rounds
      Navigator.pop(context);
    }
  }

  void _nextStep() {
    setState(() {
      switch (_currentStep) {
        case AVMStep.levelSelection:
          _currentStep = AVMStep.introText;
          break;
        case AVMStep.introText:
          _currentStep = AVMStep.introComparison;
          break;
        case AVMStep.introComparison:
          _currentStep = AVMStep.testPhase;
          break;
        case AVMStep.testPhase:
          _currentStep = AVMStep.responseWindow;
          break;
        case AVMStep.responseWindow:
          _startNextPractice();
          break;
      }
    });
  }

  void _previousStep() {
    setState(() {
      switch (_currentStep) {
        case AVMStep.introText:
          _currentStep = AVMStep.levelSelection;
          break;
        case AVMStep.introComparison:
          _currentStep = AVMStep.introText;
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentStep) {
      case AVMStep.levelSelection:
        return AVMLevelSelection(onLevelSelected: _onLevelSelected);
      case AVMStep.introText:
        return AVMIntroText(
          onNext: _nextStep,
          onBack: _previousStep,
        );
      case AVMStep.introComparison:
        return AVMIntroComparison(
          onNext: _nextStep,
          onBack: _previousStep,
        );
      case AVMStep.testPhase:
        return AVMTestScreen(
          level: _selectedLevel,
          currentPractice: _currentPractice,
          totalPractices: _totalPractices,
          onComplete: (occupied, sequence) {
            setState(() {
              _occupiedCorridors = occupied;
              _testSequence = sequence;
              _currentStep = AVMStep.responseWindow;
            });
          },
          onExit: () => Navigator.pop(context),
        );
      case AVMStep.responseWindow:
        return AVMResponseScreen(
          currentPractice: _currentPractice,
          totalPractices: _totalPractices,
          correctCities: _testSequence
              .where((f) => f['isValid'] as bool)
              .map((f) => f['city'] as String)
              .toList(),
          onComplete: _startNextPractice,
          onExit: () => Navigator.pop(context),
        );
    }
  }
}


