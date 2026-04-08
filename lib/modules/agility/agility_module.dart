import 'package:flutter/material.dart';
import 'agility_intro.dart';
import 'agility_test_screen.dart';

class AgilityModule extends StatefulWidget {
  const AgilityModule({super.key});

  @override
  State<AgilityModule> createState() => _AgilityModuleState();
}

enum AgilityState { intro, practice, realTest }

class _AgilityModuleState extends State<AgilityModule> {
  AgilityState _state = AgilityState.intro;

  @override
  Widget build(BuildContext context) {
    switch (_state) {
      case AgilityState.intro:
        return AgilityIntro(
          onNext: () => setState(() => _state = AgilityState.practice),
          onBack: () => Navigator.pop(context),
        );
      case AgilityState.practice:
        return AgilityTestScreen(
          isPractice: true,
          onSelectNext: () => setState(() => _state = AgilityState.realTest),
        );
      case AgilityState.realTest:
        return AgilityTestScreen(
          isPractice: false,
          onSelectNext: () => Navigator.pop(context),
        );
    }
  }
}

