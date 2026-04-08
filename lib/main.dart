import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'core/theme.dart';
import 'modules/dashboard/dashboard_screen.dart';
import 'modules/digit_span/digit_span_module.dart';
import 'modules/audio_visual_memory/audio_visual_memory_module.dart';
import 'modules/agility/agility_module.dart';
import 'modules/sustained_attention/sustained_attention_module.dart';
import 'modules/spatial_orientation/spatial_orientation_module.dart';
import 'modules/dimensional_spatial_perception/dimensional_spatial_perception_module.dart';

void main() {
  runApp(const ThyPaceApp());
}

class ThyPaceApp extends StatelessWidget {
  const ThyPaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/digit-span',
          builder: (context, state) => const DigitSpanModule(),
        ),
        GoRoute(
          path: '/audio-visual-memory',
          builder: (context, state) => const AudioVisualMemoryModule(),
        ),
        GoRoute(
          path: '/agility',
          builder: (context, state) => const AgilityModule(),
        ),
        GoRoute(
          path: '/sustained-attention',
          builder: (context, state) => const SustainedAttentionModule(),
        ),
        GoRoute(
          path: '/spatial-orientation',
          builder: (context, state) => const SpatialOrientationModule(),
        ),
        GoRoute(
          path: '/3d-perception',
          builder: (context, state) => const DimensionalSpatialPerceptionModule(),
        ),
      ],
    );

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'THY PACE',
          debugShowCheckedModeBanner: false,
          theme: ThyTheme.light,
          routerConfig: router,
        );
      },
    );
  }
}

