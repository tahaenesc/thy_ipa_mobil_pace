import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../components/thy_header.dart';
import 'components/agility_shape_painter.dart';

class AgilityTestScreen extends StatefulWidget {
  final bool isPractice;
  final VoidCallback onSelectNext;

  const AgilityTestScreen({
    super.key,
    required this.isPractice,
    required this.onSelectNext,
  });

  @override
  State<AgilityTestScreen> createState() => _AgilityTestScreenState();
}

class _AgilityTestScreenState extends State<AgilityTestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<AgilityShape> _shapes = [];
  final Random _random = Random();
  late Timer _spawnTimer;
  
  String _feedbackMessage = '';
  Color _feedbackColor = Colors.black;
  Timer? _feedbackTimer;

  // Reaction Area boundaries (relative to height)
  final double _reactionAreaTop = 0.4;
  final double _reactionAreaBottom = 0.6;

  int _totalShapes = 0;
  int _correctResponses = 0;
  int _countdown = 3;
  bool _isCountdownActive = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_updateShapes);

    if (widget.isPractice) {
      _startCountdown();
    } else {
      _isCountdownActive = false;
      _controller.repeat();
      _startSpawning();
    }
  }

  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        setState(() {
          _isCountdownActive = false;
        });
        _controller.repeat();
        _startSpawning();
      }
    });
  }

  void _startSpawning() {
    _spawnTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      _spawnShape();
      if (!widget.isPractice && _totalShapes >= 30) {
        timer.cancel();
      } else if (widget.isPractice && _totalShapes >= 10) {
        timer.cancel();
      }
    });
  }

  void _spawnShape() {
    final type = AgilityShapeType.values[_random.nextInt(2)];
    final color = AgilityColor.values[_random.nextInt(2)];
    final movingUp = _random.nextBool();
    
    // If moving up, start from bottom (1.0), else start from top (0.0)
    final startY = movingUp ? 1.0 : 0.0;
    final x = 0.2 + _random.nextDouble() * 0.6; // Random horizontal position
    final speed = 0.15 + _random.nextDouble() * 0.15; // Speed: 15% to 30% of screen height per second

    setState(() {
      _shapes.add(AgilityShape(
        type: type,
        color: color,
        y: startY,
        x: x,
        speed: speed,
        movingUp: movingUp,
      ));
      _totalShapes++;
    });
  }

  void _updateShapes() {
    setState(() {
      for (var shape in _shapes) {
        if (shape.movingUp) {
          shape.y -= shape.speed * 0.016; // 60fps roughly
        } else {
          shape.y += shape.speed * 0.016;
        }
      }
      
      // Remove shapes that are off-screen
      _shapes.removeWhere((s) => s.y < -0.1 || s.y > 1.1);
      
      // Check for missed shapes in practice
      if (widget.isPractice) {
        for (var shape in _shapes) {
          bool passed = shape.movingUp ? shape.y < _reactionAreaTop : shape.y > _reactionAreaBottom;
          if (passed && !shape.reagted) {
             shape.reagted = true;
             _showFeedback('Mistake 2: No Reaction', Colors.red);
          }
        }
      }
    });

    if (!widget.isPractice && _totalShapes >= 30 && _shapes.isEmpty) {
      _finishTest();
    } else if (widget.isPractice && _totalShapes >= 10 && _shapes.isEmpty) {
       _finishTest();
    }
  }

  void _handleInput(AgilityShapeType type, AgilityColor color) {
    // Find shape in reaction area
    AgilityShape? targetShape;
    for (var shape in _shapes) {
      if (shape.y >= _reactionAreaTop && shape.y <= _reactionAreaBottom && !shape.reagted) {
        targetShape = shape;
        break;
      }
    }

    if (targetShape == null) {
      if (widget.isPractice) {
        _showFeedback('Mistake 3: Timing Failure', Colors.red);
      }
      return;
    }

    targetShape.reagted = true;
    if (targetShape.type == type && targetShape.color == color) {
      _correctResponses++;
      if (widget.isPractice) {
        _showFeedback('Correct!', Colors.green);
      }
    } else {
      if (widget.isPractice) {
        String expected = _getExpectedKeyName(targetShape);
        _showFeedback('Mistake 1: Pressing the Wrong Key. Expected $expected', Colors.red);
      }
    }
  }

  String _getExpectedKeyName(AgilityShape shape) {
    if (shape.color == AgilityColor.red && shape.type == AgilityShapeType.circle) return 'Left';
    if (shape.color == AgilityColor.green && shape.type == AgilityShapeType.circle) return 'Right';
    if (shape.color == AgilityColor.red && shape.type == AgilityShapeType.square) return 'Up';
    if (shape.color == AgilityColor.green && shape.type == AgilityShapeType.square) return 'Down';
    return '';
  }

  void _showFeedback(String message, Color color) {
    _feedbackTimer?.cancel();
    setState(() {
      _feedbackMessage = message;
      _feedbackColor = color;
    });
    _feedbackTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _feedbackMessage = '');
      }
    });
  }

  void _finishTest() {
    _controller.stop();
    _spawnTimer.cancel();
    _feedbackTimer?.cancel();
    widget.onSelectNext();
  }

  @override
  void dispose() {
    _controller.dispose();
    _spawnTimer.cancel();
    _feedbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ThyHeader(title: widget.isPractice ? 'Agility - Practice' : 'Agility'),
          Expanded(
            child: Stack(
              children: [
                // Background color
                Container(color: const Color(0xFFF0F0F0)),
                
                // Reaction Area
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4 - 100, // Adjusted for layout
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.grey.shade500, width: 2),
                      ),
                    ),
                  ),
                ),

                // Moving Shapes
                Positioned.fill(
                  child: CustomPaint(
                    painter: AgilityShapePainter(
                      shapes: _shapes,
                      reactionAreaTop: _reactionAreaTop,
                      reactionAreaBottom: _reactionAreaBottom,
                    ),
                  ),
                ),

                // Countdown Overlay
                if (_isCountdownActive)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'The practice will start on the next screen...',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '$_countdown',
                          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  ),

                // Feedback Message
                if (_feedbackMessage.isNotEmpty)
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color: Colors.white.withOpacity(0.8),
                        child: Text(
                          _feedbackMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _feedbackColor),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Directional Controls
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: const Color(0xFFD9D9D9),
            child: Column(
              children: [
                _buildArrowButton('assets/images/arrow_up.png', () => _handleInput(AgilityShapeType.square, AgilityColor.red)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildArrowButton('assets/images/arrow_left.png', () => _handleInput(AgilityShapeType.circle, AgilityColor.red)),
                    const SizedBox(width: 10),
                    _buildArrowButton('assets/images/arrow_down.png', () => _handleInput(AgilityShapeType.square, AgilityColor.green)),
                    const SizedBox(width: 10),
                    _buildArrowButton('assets/images/arrow_right.png', () => _handleInput(AgilityShapeType.circle, AgilityColor.green)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton(String assetPath, VoidCallback onPressed) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Image.asset(assetPath, width: 40)),
        ),
      ),
    );
  }
}
