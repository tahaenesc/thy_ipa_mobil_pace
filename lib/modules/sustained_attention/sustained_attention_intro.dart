import 'package:flutter/material.dart';
import '../../components/intro_screen.dart';

class SustainedAttentionIntro extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isStartOfTest;

  const SustainedAttentionIntro({
    super.key,
    required this.onNext,
    required this.onBack,
    this.isStartOfTest = false,
  });

  @override
  State<SustainedAttentionIntro> createState() => _SustainedAttentionIntroState();
}

class _SustainedAttentionIntroState extends State<SustainedAttentionIntro> {
  int _currentPage = 0;

  void _handleNext() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
      });
    } else {
      widget.onNext();
    }
  }

  void _handleBack() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    } else {
      widget.onBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      title: 'Sustained Attention Test',
      onNext: _handleNext,
      onBack: _handleBack,
      children: [
        _buildPageContent(),
      ],
    );
  }

  Widget _buildPageContent() {
    if (widget.isStartOfTest) {
      return _buildReadyToStart();
    }
    switch (_currentPage) {
      case 0:
        return _buildIntroduction();
      case 1:
        return _buildRule1();
      case 2:
        return _buildRule2();
      case 3:
        return _buildRule3();
      default:
        return Container();
    }
  }

  Widget _buildReadyToStart() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Practice Complete!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'You are now ready to start the actual test.\nPress Next to begin.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      children: [
        const Text(
          'In this task, you\'ll observe circles of various colors jumping on the screen. There\'s a gray area in the middle, and when the circles enter this area, they disappear but continue moving in their original direction. Below the gray area, there are three buttons in yellow, black, and red. Your role is to control the cursor and press the button at the precise location and time based on the given instructions. Further instructions will be provided on the next screen.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        _buildVisualPlaceholder(circles: true),
      ],
    );
  }

  Widget _buildRule1() {
    return Column(
      children: [
        const Text(
          'For instance, when you see a red vertical line, you are expected to press the red button when the red circle intersects the red line.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        _buildVisualPlaceholder(line: Colors.red, isVertical: true, circleColor: Colors.red),
      ],
    );
  }

  Widget _buildRule2() {
    return Column(
      children: [
        const Text(
          'For instance, when you see a yellow horizontal line, you are expected to press the yellow button when the yellow circle exits the gray area and press the button with corresponding color.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        _buildVisualPlaceholder(line: Colors.orange, isVertical: false, circleColor: Colors.orange),
      ],
    );
  }

  Widget _buildRule3() {
    return Column(
      children: [
        const Text(
          'For instance, when you see a black vertical line, you are expected to press the black button when the yellow circle and red circle connect with each other.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        _buildVisualPlaceholder(line: Colors.black, isVertical: true, twoCircles: true),
      ],
    );
  }

  Widget _buildVisualPlaceholder({
    bool circles = false,
    Color? line,
    bool isVertical = true,
    Color? circleColor,
    bool twoCircles = false,
  }) {
    return Container(
      width: 500,
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gray Display
          Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: line != null
                ? Center(
                    child: Container(
                      width: isVertical ? 3 : double.infinity,
                      height: isVertical ? double.infinity : 3,
                      color: line,
                    ),
                  )
                : null,
          ),
          if (circles || circleColor != null || twoCircles) ...[
            if (twoCircles) ...[
              Positioned(
                left: 140,
                child: _buildCircle(Colors.orange),
              ),
              Positioned(
                right: 140,
                child: _buildCircle(Colors.red),
              ),
            ] else if (circleColor != null) ...[
              Positioned(
                left: 100,
                child: _buildCircle(circleColor),
              ),
            ] else ...[
              Positioned(
                left: 60,
                child: _buildCircle(Colors.orange),
              ),
              Positioned(
                right: 60,
                child: _buildCircle(Colors.red),
              ),
            ],
          ],
          // Buttons Preview
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButtonPreview(Colors.red),
                const SizedBox(width: 15),
                _buildButtonPreview(Colors.black),
                const SizedBox(width: 15),
                _buildButtonPreview(Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildButtonPreview(Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
