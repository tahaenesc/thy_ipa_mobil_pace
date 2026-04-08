import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../components/thy_header.dart';

class AVMTestScreen extends StatefulWidget {
  final String level;
  final int currentPractice;
  final int totalPractices;
  final Function(List<int>, List<Map<String, dynamic>>) onComplete;
  final VoidCallback onExit;

  const AVMTestScreen({
    super.key,
    required this.level,
    required this.currentPractice,
    required this.totalPractices,
    required this.onComplete,
    required this.onExit,
  });

  @override
  State<AVMTestScreen> createState() => _AVMTestScreenState();
}

class _AVMTestScreenState extends State<AVMTestScreen> {
  bool _isArrivingPhase = true;
  List<int> _occupiedCorridors = [];
  List<Map<String, dynamic>> _testSequence = [];
  int _currentInstructionIndex = -1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _setupTest();
    _startTest();
  }

  void _setupTest() {
    final random = Random();
    // Setup occupied corridors (Initial Screen) - matching video practice 1 (9 and 4)
    if (widget.currentPractice == 1) {
      _occupiedCorridors = [9, 4];
    } else {
      int count = widget.level == 'EASY' ? 2 : (widget.level == 'MEDIUM' ? 3 : 4);
      Set<int> occupied = {};
      while (occupied.length < count) {
        occupied.add(random.nextInt(10) + 1);
      }
      _occupiedCorridors = occupied.toList();
    }

    // Setup sequence of flights
    int sequenceLength = widget.level == 'EASY' ? 1 : (widget.level == 'MEDIUM' ? 2 : 3);
    List<String> cities = ['Amsterdam', 'Paris', 'London', 'Cairo', 'Moscow', 'Stockholm', 'Berlin', 'Rome', 'Madrid', 'Vienna', 'Milan', 'Bombay', 'Bremen', 'Salzburg'];
    for (int i = 0; i < sequenceLength; i++) {
      int corridor = random.nextInt(10) + 1;
      String city = cities[random.nextInt(cities.length)];
      bool isValid = !_occupiedCorridors.contains(corridor);
      _testSequence.add({
        'corridor': corridor,
        'city': city,
        'isValid': isValid,
      });
    }
  }

  void _startTest() {
    // Show Arrival phase for 4 seconds (Initial Screen)
    _timer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _isArrivingPhase = false;
          _startInstructions();
        });
      }
    });
  }

  void _startInstructions() {
    _timer?.cancel();
    _showNextInstruction(0);
  }

  void _showNextInstruction(int index) {
    if (index >= _testSequence.length) {
      // Small delay before moving to response
      _timer = Timer(const Duration(seconds: 1), () {
        if (mounted) {
          widget.onComplete(_occupiedCorridors, _testSequence);
        }
      });
      return;
    }

    if (mounted) {
      setState(() {
        _currentInstructionIndex = index;
      });
    }

    // Show each instruction for 5 seconds
    _timer = Timer(const Duration(seconds: 5), () {
      _showNextInstruction(index + 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showSpeaker = !_isArrivingPhase && _currentInstructionIndex >= 0;

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Column(
        children: [
          ThyHeader(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showSpeaker)
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.volume_up, color: Colors.white, size: 32),
                  ),
                Text(
                  'Practice ${widget.currentPractice} of ${widget.totalPractices}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildTestBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestBody() {
    return Center(
      child: Container(
        width: 1000,
        height: 600,
        color: const Color(0xFFD9D9D9),
        child: Stack(
          children: [
            // Istanbul Tower / Airport
            Positioned(
              left: 40,
              bottom: 40,
              child: Column(
                children: [
                  Image.asset('assets/images/airport.png', width: 200),
                  const SizedBox(height: 10),
                  const Text(
                    'Istanbul',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            ),

            // Arriving planes (Initial Screen phase)
            if (_isArrivingPhase)
              ..._occupiedCorridors.map((num) => _buildArrivingPlane(num)),

            // Departing plane indicator (Instruction phase)
            if (!_isArrivingPhase && _currentInstructionIndex >= 0)
              _buildDepartingPlane(_testSequence[_currentInstructionIndex]['corridor']),

            // Corridors
            Positioned(
              right: 40,
              top: 40,
              bottom: 40,
              left: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(10, (index) {
                  int num = 10 - index;
                  bool isOccupied = _occupiedCorridors.contains(num);
                  return _buildCorridorRow(num, isOccupied);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArrivingPlane(int corridorNum) {
    double top = 40 + (10 - corridorNum) * 52.0 + 10;
    return Positioned(
      right: 150,
      top: top,
      child: Image.asset('assets/images/airplane_arrival.png', width: 50),
    );
  }

  Widget _buildDepartingPlane(int corridorNum) {
    double top = 40 + (10 - corridorNum) * 52.0 + 10;
    return Positioned(
      left: 280,
      top: top,
      child: Image.asset('assets/images/airplane_departure.png', width: 50),
    );
  }

  Widget _buildCorridorRow(int num, bool isOccupied) {
    return Container(
      height: 52,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 1.5)),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Text(
            '$num. Corridor',
            style: TextStyle(
              fontSize: 16,
              color: isOccupied ? Colors.red : Colors.black,
              fontWeight: isOccupied ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isOccupied)
            const Positioned.fill(
              left: 100,
              child: Center(
                child: Text(
                  '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                  style: TextStyle(color: Colors.red, letterSpacing: 4, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

