import 'package:flutter/material.dart';
import '../../components/intro_screen.dart';

class AgilityIntro extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AgilityIntro({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<AgilityIntro> createState() => _AgilityIntroState();
}

class _AgilityIntroState extends State<AgilityIntro> {
  int _step = 1;

  void _nextStep() {
    if (_step < 3) {
      setState(() => _step++);
    } else {
      widget.onNext();
    }
  }

  void _prevStep() {
    if (_step > 1) {
      setState(() => _step--);
    } else {
      widget.onBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case 1:
        return _buildIntro1();
      case 2:
        return _buildIntro2();
      case 3:
        return _buildIntro3();
      default:
        return _buildIntro1();
    }
  }

  Widget _buildIntro1() {
    return IntroScreen(
      title: 'Cognitive Agility Test',
      onNext: _nextStep,
      onBack: widget.onBack,
      children: [
        const Text(
          'In this task, you will see circles and squares moving upward or downward at different speeds on the screen. A designated reaction area is located in the middle of the screen.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          'Your task is to follow these green and red shapes and press the button specified in the rule as soon as possible after they touch the bottom line of the reaction area (e.g., press right for green circles, left for red circles, up for red squares, and down for green squares). You are not expected to wait for the entire shape to enter the reaction area. It is considered correct to press the button specified in the rule as soon as the shapes touch the line.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          'At different stages of the test, you may be informed that the rule for the buttons to press may change. So pay close attention to the instructions and follow them accordingly.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text(
          'Be careful not to press too early or too late relative to the reaction area. Also there are stimuli that do not enter the reaction area. You should not press a key for shapes that are not in the area.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          'Your first response to each shape will be recorded. It is not necessary to provide multiple responses for a single shape. Once saved, your response can not be changed.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildIntro2() {
    return IntroScreen(
      title: 'Possible Mistakes:',
      onNext: _nextStep,
      onBack: _prevStep,
      children: [
        _buildMistakeRow(
          'Mistake 1',
          'Mistake 1: Pressing the Wrong Key According to the rule, the correct response should have been to press the left directional key, but you pressed the right directional key.',
          'assets/images/agility_mistake1.png', // We'll need to handle missing images or use placeholders
        ),
        const SizedBox(height: 20),
        _buildMistakeRow(
          'Mistake 2',
          'Mistake 2: No Reaction According to the rule, the correct response should have been to press the down button, but you did not press any key.',
          'assets/images/agility_mistake2.png',
        ),
        const SizedBox(height: 20),
        _buildMistakeRow(
          'Mistake 3',
          'Mistake 3: Timing Failure According to the rule, you shouldn\'t press a button before the stimulus enters the reaction area, but you did.',
          'assets/images/agility_mistake3.png',
        ),
      ],
    );
  }

  Widget _buildIntro3() {
    return IntroScreen(
      title: 'Instructions:',
      onNext: _nextStep,
      onBack: _prevStep,
      children: [
        const Text(
          'Please press buttons when a shape intersect with the perceptual field.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 40),
        _buildRuleItem('Left Button for Red Circles.'),
        _buildRuleItem('Right Button for Green Circles.'),
        _buildRuleItem('Up Button for Red Squares.'),
        _buildRuleItem('Down Button for Green Squares.'),
        const SizedBox(height: 40),
        _buildArrowControls(),
      ],
    );
  }

  Widget _buildMistakeRow(String title, String description, String imagePath) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.grey.shade200,
          ),
          child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)), // Placeholder
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              Text(description, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRuleItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildArrowControls() {
    return Column(
      children: [
        _buildArrowButton('assets/images/arrow_up.png'),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildArrowButton('assets/images/arrow_left.png'),
            const SizedBox(width: 5),
            _buildArrowButton('assets/images/arrow_down.png'),
            const SizedBox(width: 5),
            _buildArrowButton('assets/images/arrow_right.png'),
          ],
        ),
      ],
    );
  }

  Widget _buildArrowButton(String assetPath) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Image.asset(assetPath, width: 30),
      ),
    );
  }
}

