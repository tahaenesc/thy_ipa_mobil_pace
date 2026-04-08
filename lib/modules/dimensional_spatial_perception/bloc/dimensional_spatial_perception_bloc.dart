import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../logic/eighth_algo_generator.dart';

part 'dimensional_spatial_perception_event.dart';
part 'dimensional_spatial_perception_state.dart';

class DimensionalSpatialPerceptionBloc
    extends
        Bloc<
          DimensionalSpatialPerceptionEvent,
          DimensionalSpatialPerceptionState
        > {
  final EighthAlgoGenerator _algoGenerator = EighthAlgoGenerator();
  Timer? _timer;

  DimensionalSpatialPerceptionBloc()
    : super(const DimensionalSpatialPerceptionState()) {
    on<StartTest>(_onStartTest);
    on<NextPhase>(_onNextPhase);
    on<SelectAnswer>(_onSelectAnswer);
    on<TimerTick>(_onTimerTick);
    on<QuitTest>(_onQuitTest);
  }

  void _onStartTest(
    StartTest event,
    Emitter<DimensionalSpatialPerceptionState> emit,
  ) {
    final sets = _algoGenerator.generateQuestions();
    emit(
      state.copyWith(
        questionSets: sets,
        currentQuestionIndex: 0,
        phase: TestPhase.intro1,
        isPractice: event.isPractice,
      ),
    );
  }

  void _onNextPhase(
    NextPhase event,
    Emitter<DimensionalSpatialPerceptionState> emit,
  ) {
    _stopTimer();

    switch (state.phase) {
      case TestPhase.intro1:
        emit(state.copyWith(phase: TestPhase.intro2));
        break;
      case TestPhase.intro2:
        emit(state.copyWith(phase: TestPhase.countdown));
        _startCountdown(emit);
        break;
      case TestPhase.countdown:
        emit(state.copyWith(phase: TestPhase.test, timeLeft: 40));
        _startTestTimer();
        break;
      case TestPhase.test:
        if (state.currentQuestionIndex < (state.questionSets.length - 1)) {
          emit(
            state.copyWith(
              currentQuestionIndex: state.currentQuestionIndex + 1,
              selectedAnswerIndex: -1,
              timeLeft: 40,
            ),
          );
          _startTestTimer();
        } else {
          emit(state.copyWith(phase: TestPhase.finished));
        }
        break;
      case TestPhase.finished:
        // Already finished
        break;
    }
  }

  void _onSelectAnswer(
    SelectAnswer event,
    Emitter<DimensionalSpatialPerceptionState> emit,
  ) {
    emit(state.copyWith(selectedAnswerIndex: event.index));
  }

  void _onTimerTick(
    TimerTick event,
    Emitter<DimensionalSpatialPerceptionState> emit,
  ) {
    if (state.timeLeft > 0) {
      emit(state.copyWith(timeLeft: state.timeLeft - 1));
    } else {
      add(const NextPhase());
    }
  }

  void _onQuitTest(
    QuitTest event,
    Emitter<DimensionalSpatialPerceptionState> emit,
  ) {
    _stopTimer();
    emit(state.copyWith(phase: TestPhase.finished));
  }

  void _startCountdown(Emitter<DimensionalSpatialPerceptionState> emit) {
    // Usually a 3-second countdown
    int count = 3;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        count--;
      } else {
        add(const NextPhase());
      }
    });
  }

  void _startTestTimer() {
    _stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(const TimerTick());
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
