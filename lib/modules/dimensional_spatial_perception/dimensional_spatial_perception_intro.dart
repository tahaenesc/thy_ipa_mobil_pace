import 'package:flutter/material.dart';
import '../../components/intro_screen.dart';
import 'models/house_model.dart';
import 'components/house_view.dart';

class DimensionalSpatialPerceptionIntro1 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const DimensionalSpatialPerceptionIntro1({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      title: '3 Dimensional Spatial Perception',
      onNext: onNext,
      onBack: onBack,
      children: [
        Center(
          child: Container(
            width: 300,
            height: 250,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: HouseView(
              house: House(
                houseIndex: 1,
                houseType: HouseType.single,
                name: 'single/single_7/front_right.svg', // Example house from screenshot
                rightWindow: true,
                leftWindow: true,
                chimney: true,
                rotationAngle: 0,
                colorPalette: ColorPalette.set2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DimensionalSpatialPerceptionIntro2 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const DimensionalSpatialPerceptionIntro2({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      title: 'Three-Dimensional Spatial Perception Test',
      onNext: onNext,
      onBack: onBack,
      children: [
        const SizedBox(height: 100),
        const Center(
          child: Text(
            'Three-Dimensional Spatial Perception Test',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 40),
        const Text(
          'In this task, you will see a house and its views from both sides. Following that, four houses will be presented to you. One of these houses is a rotated view of the target house. Your task is to quickly decide which house is the rotated version of the one shown earlier and select the house you have chosen.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        const Text(
          'Once you are sure of your answer, you can click the next button and continue. You have limited time to select your response.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
