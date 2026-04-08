import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'bloc/dimensional_spatial_perception_bloc.dart';
import 'dimensional_spatial_perception_intro.dart';
import 'screens/dimensional_spatial_perception_test_screen.dart';
import 'screens/difficulty_screen.dart';

class DimensionalSpatialPerceptionModule extends StatelessWidget {
  const DimensionalSpatialPerceptionModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DimensionalSpatialPerceptionBloc(),
      child: const _DimensionalSpatialPerceptionView(),
    );
  }
}

class _DimensionalSpatialPerceptionView extends StatelessWidget {
  const _DimensionalSpatialPerceptionView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DimensionalSpatialPerceptionBloc, DimensionalSpatialPerceptionState>(
      listener: (context, state) {
        if (state.phase == TestPhase.finished) {
          context.pop();
        }
      },
      builder: (context, state) {
        // Initial state: Show difficulty selection
        if (state.questionSets.isEmpty) {
          return DimensionalSpatialPerceptionDifficultyScreen(
            onDifficultySelected: (difficulty) {
              context.read<DimensionalSpatialPerceptionBloc>().add(const StartTest(isPractice: true));
            },
          );
        }

        switch (state.phase) {
          case TestPhase.intro1:
            return DimensionalSpatialPerceptionIntro1(
              onNext: () => context.read<DimensionalSpatialPerceptionBloc>().add(const NextPhase()),
              onBack: () => context.pop(),
            );
          case TestPhase.intro2:
            return DimensionalSpatialPerceptionIntro2(
              onNext: () => context.read<DimensionalSpatialPerceptionBloc>().add(const NextPhase()),
              onBack: () => context.read<DimensionalSpatialPerceptionBloc>().add(const NextPhase()), // Simplified back for now
            );
          case TestPhase.countdown:
            return _buildCountdown(context);
          case TestPhase.test:
            return const DimensionalSpatialPerceptionTestScreen();
          case TestPhase.finished:
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _buildCountdown(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: Center(
        child: Text(
          'Starting...',
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
