import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dimensional_spatial_perception_bloc.dart';
import '../components/house_view.dart';
import '../models/house_model.dart';
import '../logic/eighth_algo_generator.dart';

class DimensionalSpatialPerceptionTestScreen extends StatelessWidget {
  const DimensionalSpatialPerceptionTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DimensionalSpatialPerceptionBloc, DimensionalSpatialPerceptionState>(
      builder: (context, state) {
        final currentSet = state.currentQuestionSet;
        if (currentSet == null) return const SizedBox.shrink();

        final houses = currentSet.toHouseList();
        final referenceHouses = houses.sublist(0, 2);
        final optionHouses = houses.sublist(2);

        return Scaffold(
          backgroundColor: const Color(0xFFD9D9D9),
          body: Column(
            children: [
              _buildHeader(context, state),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Reference Houses (Top Row)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHouseContainer(referenceHouses[0], width: 250, height: 250),
                          const SizedBox(width: 40),
                          _buildHouseContainer(referenceHouses[1], width: 250, height: 250),
                        ],
                      ),
                      const SizedBox(height: 60),
                      // Option Houses (Bottom Row)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: _buildOption(context, state, optionHouses[index], index),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              _buildFooter(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, DimensionalSpatialPerceptionState state) {
    return Container(
      color: const Color(0xFF333333),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/logo.png', height: 40),
              const SizedBox(width: 15),
              const Text(
                'TURKISH AIRLINES',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          if (state.isPractice)
            Text(
              'Practice ${state.currentQuestionIndex + 1} of 15',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ElevatedButton(
            onPressed: () => context.read<DimensionalSpatialPerceptionBloc>().add(const QuitTest()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD9D9D9),
              foregroundColor: Colors.black,
            ),
            child: const Text('Exit ->'),
          ),
        ],
      ),
    );
  }

  Widget _buildHouseContainer(House house, {double width = 200, double height = 200}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(10),
      child: HouseView(house: house),
    );
  }

  Widget _buildOption(BuildContext context, DimensionalSpatialPerceptionState state, House house, int index) {
    final bool isSelected = state.selectedAnswerIndex == index;
    final String letter = ['A', 'B', 'C', 'D'][index];
    
    // In practice mode, we show green/red colors after selection
    Color? textColor;
    if (state.isPractice && isSelected) {
      textColor = house.isAnswer ? Colors.green : Colors.red;
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () => context.read<DimensionalSpatialPerceptionBloc>().add(SelectAnswer(index)),
          child: _buildHouseContainer(house, width: 180, height: 180),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (_) => context.read<DimensionalSpatialPerceptionBloc>().add(SelectAnswer(index)),
            ),
            Text(
              letter,
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => context.read<DimensionalSpatialPerceptionBloc>().add(const NextPhase()),
            child: const Text('Next ->'),
          ),
        ],
      ),
    );
  }
}
