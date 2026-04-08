import 'package:flutter/material.dart';
import '../../components/intro_screen.dart';

class SpatialOrientationIntro extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const SpatialOrientationIntro({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      title: 'Spatial Orientation',
      onNext: onNext,
      onBack: onBack,
      children: [
        Container(
          width: 400,
          height: 480,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            color: const Color(0xFFD9D9D9),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Maze Area
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMazeGrid(),
                  const SizedBox(width: 20),
                  _buildArrowControls(),
                ],
              ),
              const SizedBox(height: 40),
              // Bottom Text
              const Text(
                'Spatial Orientation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMazeGrid() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.white,
      child: Stack(
        children: [
          // Grid lines
          Positioned.fill(
            child: CustomPaint(
              painter: MazePainter(),
            ),
          ),
          // Active quad (top right)
          Positioned(
            left: 100,
            top: 0,
            width: 100,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Grayed out quads
          _buildGrayQuad(0, 0),
          _buildGrayQuad(0, 100),
          _buildGrayQuad(100, 100),
        ],
      ),
    );
  }

  Widget _buildGrayQuad(double left, double top) {
    return Positioned(
      left: left,
      top: top,
      width: 100,
      height: 100,
      child: Container(
        color: Colors.black.withOpacity(0.2),
        child: Opacity(
          opacity: 0.3,
          child: CustomPaint(painter: MazePainter()),
        ),
      ),
    );
  }

  Widget _buildArrowControls() {
    return Column(
      children: [
        _buildArrowButton('assets/images/arrow_up.png'),
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
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Image.asset(assetPath, width: 15),
    );
  }
}

class MazePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;
    
    // Draw dummy maze lines
    for (int i = 0; i < 200; i += 10) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(i.toDouble(), 10), p);
      canvas.drawLine(Offset(0, i.toDouble()), Offset(10, i.toDouble()), p);
    }
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
