import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/thy_header.dart';
import '../../components/intro_screen.dart';
import 'models/maze.dart';
import 'models/maze_cell.dart';
import 'logic/maze_generator.dart';
import 'ui/maze_painter.dart';

enum TestState { intro, difficulty, countdown, active, result }

class SpatialOrientationModule extends StatefulWidget {
  const SpatialOrientationModule({super.key});

  @override
  State<SpatialOrientationModule> createState() => _SpatialOrientationModuleState();
}

class _SpatialOrientationModuleState extends State<SpatialOrientationModule> {
  TestState _state = TestState.intro;
  int _difficultySize = 15;
  int _practiceIndex = 0;
  final int _totalPractices = 15;
  
  Maze? _maze;
  Offset _ballPos = const Offset(1, 0); 
  MazeAxis _activeAxis = MazeAxis.none;
  bool _isBallStandBy = false;
  int _movesUntilSwitch = 0;
  final Random _random = Random();
  
  Timer? _gameTimer;
  int _timeLeft = 0;
  DateTime? _startTime;

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void _startTest(int size) {
    setState(() {
      _difficultySize = size;
      _state = TestState.countdown;
    });
  }

  void _onCountdownComplete() {
    _generateNewLevel();
    setState(() {
      _state = TestState.active;
      _startTime = DateTime.now();
    });
    _startTimer();
  }

  void _generateNewLevel() {
    _maze = MazeGenerator().generate(_difficultySize);
    for (int y = 0; y < _maze!.size; y++) {
      for (int x = 0; x < _maze!.size; x++) {
        if (_maze!.grid[y][x].type == CellType.entry) {
          _ballPos = Offset(x.toDouble(), y.toDouble());
          break;
        }
      }
    }
    _activeAxis = MazeAxis.values[_random.nextInt(4)];
    _movesUntilSwitch = _random.nextInt(4) + 2; 
    _isBallStandBy = false;
    _timeLeft = 60; 
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _finishRound(false);
      }
    });
  }

  void _handleMove(String direction) {
    if (_state != TestState.active) return;
    if (_isBallStandBy) {
      setState(() => _isBallStandBy = false);
      return;
    }

    int dx = 0, dy = 0;
    switch (direction) {
      case 'up': dy = -1; break;
      case 'down': dy = 1; break;
      case 'left': dx = -1; break;
      case 'right': dx = 1; break;
    }

    int adjDx = dx, adjDy = dy;
    if (_activeAxis == MazeAxis.horizontal || _activeAxis == MazeAxis.both) adjDx = -dx;
    if (_activeAxis == MazeAxis.vertical || _activeAxis == MazeAxis.both) adjDy = -dy;

    int nx = _ballPos.dx.toInt() + adjDx;
    int ny = _ballPos.dy.toInt() + adjDy;

    if (nx >= 0 && nx < _maze!.size && ny >= 0 && ny < _maze!.size) {
      if (!_maze!.grid[ny][nx].isWall) {
        setState(() {
          _ballPos = Offset(nx.toDouble(), ny.toDouble());
          _movesUntilSwitch--;
          if (_maze!.grid[ny][nx].type == CellType.exit) {
            _finishRound(true);
          } else if (_movesUntilSwitch <= 0) {
            _switchQuadrant();
          }
        });
      }
    }
  }

  void _switchQuadrant() {
    List<MazeAxis> others = MazeAxis.values.where((a) => a != _activeAxis).toList();
    _activeAxis = others[_random.nextInt(3)];
    _movesUntilSwitch = _random.nextInt(4) + 2;
    _isBallStandBy = true;
  }

  void _finishRound(bool success) {
    _gameTimer?.cancel();
    if (_practiceIndex < _totalPractices - 1) {
      setState(() {
        _practiceIndex++;
        _state = TestState.countdown;
      });
    } else {
      setState(() => _state = TestState.result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    switch (_state) {
      case TestState.intro: return _buildIntro();
      case TestState.difficulty: return _buildDifficulty();
      case TestState.countdown: return _buildCountdown();
      case TestState.active: return _buildGame();
      case TestState.result: return _buildResult();
    }
  }

  Widget _buildIntro() {
    return IntroScreen(
      title: 'Spatial Orientation Test',
      onNext: () => setState(() => _state = TestState.difficulty),
      onBack: () => Navigator.pop(context),
      children: [
        const Text(
          'In this task, you will encounter a maze made up of four different symmetries. The maze features four entrances, and a ball is thrown into it from the starting point. Your objective is to guide the ball to the central empty space as soon as possible.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        const Text(
          'However, as you make moves, the ball moves to a symmetrical position in another maze. Your task is to consistently achieve the same goal (guiding the ball to the central space as soon as possible) in various mazes with the same symmetry. Each maze must be completed within a specified time, and you will be informed about the allocated time for each maze from the beginning.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDifficulty() {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Column(
        children: [
          const ThyHeader(title: 'Level Selection'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _difficultyCard('EASY', 15),
                      SizedBox(width: 25.w),
                      _difficultyCard('MEDIUM', 23),
                      SizedBox(width: 25.w),
                      _difficultyCard('HARD', 31),
                    ],
                  ),
                ),
                SizedBox(height: 60.h),
                Text(
                  'Please choose a level to start...', 
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _difficultyCard(String label, int size) {
    return InkWell(
      onTap: () => _startTest(size),
      child: Container(
        width: 170.w,
        height: 200.h,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9), 
          border: Border.all(color: Colors.black, width: 1.5.w)
        ),
        child: Column(
          children: [
            const Spacer(),
            if (size >= 15) Image.asset('assets/images/thy_icon.png', width: 40.w, color: Colors.black54),
            if (size >= 23) Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset('assets/images/thy_icon.png', width: 40.w, color: Colors.black54),
                SizedBox(width: 5.w),
                Image.asset('assets/images/thy_icon.png', width: 40.w, color: Colors.black54),
              ]),
            ),
            if (size >= 31) Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset('assets/images/thy_icon.png', width: 40.w, color: Colors.black54),
                SizedBox(width: 5.w),
                Image.asset('assets/images/thy_icon.png', width: 40.w, color: Colors.black54),
                SizedBox(width: 5.w),
                Image.asset('assets/images/thy_icon.png', width: 40.w, color: Colors.black54),
              ]),
            ),
            const Spacer(),
            Text(
              label, 
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16.sp)
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdown() {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Column(
        children: [
          ThyHeader(
            title: 'Turkish Airlines',
            trailing: Text(
              'Practice ${_practiceIndex + 1} of $_totalPractices',
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
          Expanded(child: _CountdownWidget(onComplete: _onCountdownComplete)),
        ],
      ),
    );
  }

  Widget _buildGame() {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Column(
        children: [
          ThyHeader(
            title: 'Turkish Airlines',
            trailing: Text(
              'Practice ${_practiceIndex + 1} of $_totalPractices',
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 400.w, maxHeight: 400.w),
                          margin: EdgeInsets.all(20.w),
                          color: Colors.grey.shade400,
                          child: Column(
                            children: [
                              Expanded(child: Row(children: [
                                Expanded(child: _buildQuadrant(MazeAxis.none)),
                                SizedBox(width: 4.w),
                                Expanded(child: _buildQuadrant(MazeAxis.horizontal)),
                              ])),
                              SizedBox(height: 4.h),
                              Expanded(child: Row(children: [
                                Expanded(child: _buildQuadrant(MazeAxis.vertical)),
                                SizedBox(width: 4.w),
                                Expanded(child: _buildQuadrant(MazeAxis.both)),
                              ])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildControls(),
                    SizedBox(height: 20.h),
                    _buildTimerInfo(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuadrant(MazeAxis axis) {
    if (_maze == null) return const SizedBox();
    bool isActive = _activeAxis == axis;
    return CustomPaint(
      painter: MazePainter(
        maze: _maze!,
        axis: axis,
        ballPosition: isActive ? _ballPos : null,
        isActive: isActive,
        isBallStandBy: _isBallStandBy,
      ),
      size: Size.infinite,
    );
  }

  Widget _buildTimerInfo() {
    return Column(children: [
      Icon(Icons.timer_outlined, size: 40.sp),
      SizedBox(height: 8.h),
      Text('$_timeLeft s', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _buildControls() {
    return Column(children: [
      _arrowBtn('up'),
      SizedBox(height: 5.h),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _arrowBtn('left'),
        SizedBox(width: 10.w),
        SizedBox(width: 60.w, height: 60.h), 
        SizedBox(width: 10.w),
        _arrowBtn('right'),
      ]),
      SizedBox(height: 5.h),
      _arrowBtn('down'),
    ]);
  }

  Widget _arrowBtn(String dir) {
    return GestureDetector(
      onTap: () => _handleMove(dir),
      child: Container(
        width: 60.w, height: 60.w,
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(8.r)),
        child: Center(child: Image.asset('assets/images/arrow_$dir.png', width: 30.w)),
      ),
    );
  }

  Widget _buildResult() {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Column(
        children: [
          const ThyHeader(title: 'Test Completed'),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 100.sp, color: Colors.green),
                  SizedBox(height: 20.h),
                  Text('Test Completed', style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 40.h),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, 
                      foregroundColor: Colors.white, 
                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h)
                    ),
                    child: Text('Back to Menu', style: TextStyle(fontSize: 18.sp)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownWidget extends StatefulWidget {
  final VoidCallback onComplete;
  const _CountdownWidget({required this.onComplete});
  @override
  State<_CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<_CountdownWidget> {
  int _count = 3;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_count > 1) setState(() => _count--);
      else { _timer.cancel(); widget.onComplete(); }
    });
  }
  @override
  void dispose() { _timer.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('The test will start on the next screen...', style: TextStyle(fontSize: 24.sp), textAlign: TextAlign.center),
        SizedBox(height: 40.h),
        Text('$_count', style: TextStyle(fontSize: 120.sp, color: Colors.black26)),
      ],
    ));
  }
}
