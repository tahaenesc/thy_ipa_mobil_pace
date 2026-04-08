import 'package:flutter/material.dart';
import '../../components/thy_header.dart';
import '../../core/theme.dart';

class AVMLevelSelection extends StatelessWidget {
  final Function(String) onLevelSelected;

  const AVMLevelSelection({super.key, required this.onLevelSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ThyHeader(title: 'Introduction'),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLevelCard(context, 'EASY', 1),
                        const SizedBox(width: 40),
                        _buildLevelCard(context, 'MEDIUM', 2),
                        const SizedBox(width: 40),
                        _buildLevelCard(context, 'HARD', 3),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Please choose a level to start...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, String level, int leafCount) {
    return GestureDetector(
      onTap: () => onLevelSelected(level),
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(leafCount, (index) {
                return Image.asset(
                  'assets/images/menu/leaf.png',
                  width: 50,
                  height: 50,
                );
              }),
            ),
            const Spacer(),
            Text(
              level,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
