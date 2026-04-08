import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../components/thy_header.dart';
import 'components/sustained_attention_painter.dart';

class SustainedAttentionTestScreen extends StatefulWidget {
  final bool isPractice;
  final VoidCallback onFinish;

  const SustainedAttentionTestScreen({
    super.key,
    required this.isPractice,
    required this.onFinish,
  });

  @override
  State<SustainedAttentionTestScreen> createState() => _SustainedAttentionTestScreenState();
}

class _SustainedAttentionTestScreenState extends State<SustainedAttentionTestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<SustainedAttentionCircle> _circles = [];
  final Random _random = Random();
  
  SustainedAttentionLineType _currentLineType = SustainedAttentionLineType.none;
  Color? _currentLineColor;
  
  Timer? _eventTimer;
  Timer? _feedbackTimer;
  String _feedbackMessage = '';
  Color _feedbackColor = Colors.black;

  int _totalEvents = 0;
  int _correctResponses = 0;
  int _countdown = 3;
  bool _isCountdownActive = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_updateAnimation);

    _startCountdown();
  }

  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        setState(() => _isCountdownActive = false);
        _controller.repeat();
        _startEvents();
      }
    });
  }

  void _startEvents() {
    _scheduleNextEvent();
  }

  void _scheduleNextEvent() {
    final delay = 2000 + _random.nextInt(3000); // 2-5 seconds between events
    _eventTimer = Timer(Duration(milliseconds: delay), () {
      if (!mounted) return;
      _spawnEvent();
      _totalEvents++;
      
      final limit = widget.isPractice ? 10 : 30;
      if (_totalEvents < limit) {
        _scheduleNextEvent();
      } else {
        Timer(const Duration(seconds: 5), _finishTest);
      }
    });
  }

  void _spawnEvent() {
    final typeIndex = _random.nextInt(3); // 0: Red, 1: Orange, 2: Black
    
    setState(() {
      _circles.clear();
      if (typeIndex == 0) {
        // Red Vertical Line + Red Circle
        _currentLineType = SustainedAttentionLineType.vertical;
        _currentLineColor = Colors.red;
        _circles.add(SustainedAttentionCircle(
          x: -0.1, y: 0.5, color: Colors.red, isRed: true,
        ));
      } else if (typeIndex == 1) {
        // Orange Horizontal Line + Orange Circle
        _currentLineType = SustainedAttentionLineType.horizontal;
        _currentLineColor = Colors.orange;
        _circles.add(SustainedAttentionCircle(
          x: 1.1, y: 0.5, color: Colors.orange, isRed: false,
        ));
      } else {
        // Black Vertical Line + Two Circles
        _currentLineType = SustainedAttentionLineType.black;
        _currentLineColor = Colors.black;
        _circles.add(SustainedAttentionCircle(
          x: -0.1, y: 0.5, color: Colors.orange, isRed: false,
        ));
        _circles.add(SustainedAttentionCircle(
          x: 1.1, y: 0.5, color: Colors.red, isRed: true,
        ));
      }
    });
  }

  void _updateAnimation() {
    if (!mounted) return;
    
    setState(() {
      for (var circle in _circles) {
        if (circle.x < 0.5 && circle.isRed) { // Red moves right
           circle.x += 0.005;
        } else if (circle.x > 0.5 && !circle.isRed) { // Orange moves left
           circle.x -= 0.005;
        } else if (circle.isRed && circle.readyToExit) {
           circle.x += 0.005;
        } else if (!circle.isRed && circle.readyToExit) {
           circle.x -= 0.005;
        }
        
        // Logical flags for events
        if (circle.isRed && circle.x >= 0.5 && !circle.reachedCenter) {
          circle.reachedCenter = true;
          // For single red event, it should stay at center until next event or until it "passes"
        }
        if (!circle.isRed && circle.x <= 0.5 && !circle.reachedCenter) {
          circle.reachedCenter = true;
        }

        // Logic for exiting the gray area (simulated)
        if (circle.reachedCenter && !circle.readyToExit) {
          // Keep it "hidden" or at center for a brief moment then move out
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) setState(() => circle.readyToExit = true);
          });
        }
        
        if (circle.x < -0.2 || circle.x > 1.2) {
          circle.exited = true;
        }
      }
    });

    // Check for missed responses in practice
    if (widget.isPractice) {
       // Check if any circle that should have been reacted to has exited
       for (var circle in _circles) {
         if (circle.exited && !circle.reacted) {
           circle.reacted = true; // Mark to avoid multiple messages
           _showFeedback('Missed!', Colors.red);
         }
       }
    }
  }

  void _handleInput(Color buttonColor) {
    if (_circles.isEmpty) return;

    bool correct = false;
    String message = '';

    if (_currentLineType == SustainedAttentionLineType.vertical && _currentLineColor == Colors.red) {
      // Red event
      final redCircle = _circles.firstWhere((c) => c.isRed);
      if (buttonColor == Colors.red && redCircle.reachedCenter && !redCircle.reacted) {
        correct = true;
        redCircle.reacted = true;
      } else {
        message = 'Wrong timing or button (Expected Red at line)';
      }
    } else if (_currentLineType == SustainedAttentionLineType.horizontal && _currentLineColor == Colors.orange) {
      // Orange event
      final orangeCircle = _circles.firstWhere((c) => !c.isRed);
      if (buttonColor == Colors.orange && orangeCircle.readyToExit && !orangeCircle.reacted) {
        correct = true;
        orangeCircle.reacted = true;
      } else {
        message = 'Wrong timing or button (Expected Orange at exit)';
      }
    } else if (_currentLineType == SustainedAttentionLineType.black) {
      // Black event (Two circles connecting)
      if (buttonColor == Colors.black) {
        bool bothAtCenter = _circles.every((c) => c.reachedCenter && !c.readyToExit);
        if (bothAtCenter && !_circles.every((c) => c.reacted)) {
          correct = true;
          for (var c in _circles) c.reacted = true;
        } else {
          message = 'Wrong timing (Expected Black when color circles connect)';
        }
      }
    }

    if (correct) {
      _correctResponses++;
      if (widget.isPractice) _showFeedback('Correct!', Colors.green);
    } else if (widget.isPractice && message.isNotEmpty) {
      _showFeedback(message, Colors.red);
    }
  }

  void _showFeedback(String message, Color color) {
    _feedbackTimer?.cancel();
    setState(() {
      _feedbackMessage = message;
      _feedbackColor = color;
    });
    _feedbackTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) setState(() => _feedbackMessage = '');
    });
  }

  void _finishTest() {
    _controller.stop();
    _eventTimer?.cancel();
    _feedbackTimer?.cancel();
    widget.onFinish();
  }

  @override
  void dispose() {
    _controller.dispose();
    _eventTimer?.cancel();
    _feedbackTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ThyHeader(title: widget.isPractice ? 'Sustained Attention - Practice' : 'Sustained Attention'),
          Expanded(
            child: Stack(
              children: [
                Container(color: const Color(0xFFF0F0F0)),
                
                // Display Area
                Center(
                  child: Container(
                    width: 400,
                    height: 300,
                    child: CustomPaint(
                      painter: SustainedAttentionPainter(
                        circles: _circles,
                        lineType: _currentLineType,
                        lineColor: _currentLineColor,
                      ),
                    ),
                  ),
                ),

                // Countdown
                if (_isCountdownActive)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'The test will start on the next screen...',
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

                // Feedback
                if (_feedbackMessage.isNotEmpty)
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color: Colors.white.withOpacity(0.9),
                        child: Text(
                          _feedbackMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _feedbackColor),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Controls
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            color: const Color(0xFFD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTestButton('assets/images/red_button.png', () => _handleInput(Colors.red)),
                const SizedBox(width: 40),
                _buildTestButton('assets/images/black_button.png', () => _handleInput(Colors.black)),
                const SizedBox(width: 40),
                _buildTestButton('assets/images/orange_button.png', () => _handleInput(Colors.orange)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestButton(String assetPath, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Image.asset(assetPath, width: 80),
    );
  }
}
