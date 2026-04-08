part of 'dimensional_spatial_perception_bloc.dart';

enum TestPhase { intro1, intro2, countdown, test, finished }

class DimensionalSpatialPerceptionState extends Equatable {
  final List<QuestionSet> questionSets;
  final int currentQuestionIndex;
  final TestPhase phase;
  final int selectedAnswerIndex;
  final int timeLeft;
  final bool isPractice;

  const DimensionalSpatialPerceptionState({
    this.questionSets = const [],
    this.currentQuestionIndex = 0,
    this.phase = TestPhase.intro1,
    this.selectedAnswerIndex = -1,
    this.timeLeft = 0,
    this.isPractice = true,
  });

  QuestionSet? get currentQuestionSet => 
    (questionSets.isNotEmpty && currentQuestionIndex < questionSets.length) 
    ? questionSets[currentQuestionIndex] 
    : null;

  DimensionalSpatialPerceptionState copyWith({
    List<QuestionSet>? questionSets,
    int? currentQuestionIndex,
    TestPhase? phase,
    int? selectedAnswerIndex,
    int? timeLeft,
    bool? isPractice,
  }) {
    return DimensionalSpatialPerceptionState(
      questionSets: questionSets ?? this.questionSets,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      phase: phase ?? this.phase,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      timeLeft: timeLeft ?? this.timeLeft,
      isPractice: isPractice ?? this.isPractice,
    );
  }

  @override
  List<Object?> get props => [
    questionSets,
    currentQuestionIndex,
    phase,
    selectedAnswerIndex,
    timeLeft,
    isPractice,
  ];
}
