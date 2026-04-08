import 'package:flutter/material.dart';
import '../../../components/thy_header.dart';

class DimensionalSpatialPerceptionDifficultyScreen extends StatelessWidget {
  final Function(String difficulty) onDifficultySelected;

  const DimensionalSpatialPerceptionDifficultyScreen({
    super.key,
    required this.onDifficultySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: Column(
        children: [
          const ThyHeader(),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLevelCard('EASY', 'assets/images/menu/leaf.png', 1),
                  const SizedBox(width: 30),
                  _buildLevelCard('MEDIUM', 'assets/images/menu/leaf.png', 2),
                  const SizedBox(width: 30),
                  _buildLevelCard('HARD', 'assets/images/menu/leaf.png', 3),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Please choose a level to start...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(String title, String iconPath, int leafCount) {
    return InkWell(
      onTap: () => onDifficultySelected(title),
      child: Container(
        width: 250,
        height: 350,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: const Color(0xFFD9D9D9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(leafCount, (index) => Image.asset(iconPath, width: 40)),
            ),
            const SizedBox(height: 100),
            Text(
              title,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
