part of 'dimensional_spatial_perception_bloc.dart';

abstract class DimensionalSpatialPerceptionEvent extends Equatable {
  const DimensionalSpatialPerceptionEvent();

  @override
  List<Object?> get props => [];
}

class StartTest extends DimensionalSpatialPerceptionEvent {
  final bool isPractice;
  const StartTest({this.isPractice = true});

  @override
  List<Object?> get props => [isPractice];
}

class NextPhase extends DimensionalSpatialPerceptionEvent {
  const NextPhase();
}

class SelectAnswer extends DimensionalSpatialPerceptionEvent {
  final int index;
  const SelectAnswer(this.index);

  @override
  List<Object?> get props => [index];
}

class TimerTick extends DimensionalSpatialPerceptionEvent {
  const TimerTick();
}

class QuitTest extends DimensionalSpatialPerceptionEvent {
  const QuitTest();
}
