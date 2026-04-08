import 'package:flutter/material.dart';
import '../../components/intro_screen.dart';

class AVMIntroText extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AVMIntroText({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      title: 'Audio Visual Memory Test-1',
      onNext: onNext,
      onBack: onBack,
      children: const [
        Text(
          'This task consists of both visual and auditory elements. Once the test starts, you will be presented with an image consisting of air corridors and planes arriving in Istanbul. On the next screen, you will see a plane departing from Istanbul and listen to audio instructions for the corresponding plane. Once a certain number of auditory instructions are presented, the response window will open, and the sequence will be completed. Afterwards, a new sequence will start, and the series will be presented one after the other throughout the test.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
        SizedBox(height: 20),
        Text(
          'The initial screen of each series shows two planes arriving in Istanbul on two different corridors. You should pay attention to the occupied corridors and remember those corridors, since they won’t be presented again on the following screens. Furthermore, subsequent to the first screen, there will be a plane departing from Istanbul and waiting for instructions about the flight corridor and destination city on the left side of one of the corridors on each new screen. These instructions will include information about which corridor and which city the plane will fly to.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
        SizedBox(height: 20),
        Text(
          'Based on the given auditory instructions, your task is to determine whether the plane can fly on that corridor. The plane can fly on a corridor only if no planes fly to Istanbul on that corridor. If a corridor is occupied by a plane arriving in Istanbul, the plane on the left side can’t fly on that corridor. You need to remember the destination cities of the flights, only for which you decided to fly on the given corridors. Once the response window opens, you need to select those cities from the list.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class AVMIntroComparison extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const AVMIntroComparison({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      title: 'Instructions',
      onNext: onNext,
      onBack: onBack,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildVisualBox('Initial Screen', true),
            const SizedBox(width: 40),
            _buildVisualBox('Second Screen', false),
          ],
        ),
        const SizedBox(height: 40),
        const Text(
          'When you receive an auditory instruction about a flight\'s corridor, first check if the corridor mentioned is available, remembering that corridors 5 and 9 are currently occupied. It\'s important to remember the destinations of flights in the available corridors. For example, if the instruction is \'To Amsterdam on Corridor 8\', remember this as Corridor 8 is open and available for a plane to fly to Amsterdam. However, if the instruction is \'To Miami on Corridor 5\', you don\'t need to remember this because Corridor 5 is already occupied by a flight to Istanbul and is not available for use.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
        const SizedBox(height: 20),
        const Text(
          'You can continue the practice by pressing the next button. Upon completion of the practice, relevant information will be displayed on the screen.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildVisualBox(String title, bool isInitial) {
    return Column(
      children: [
        Container(
          width: 350,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: const Color(0xFFD9D9D9),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 80,
                child: Column(
                  children: [
                    Image.asset('assets/images/airport.png', width: 60),
                    const Text('Istanbul', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              if (!isInitial)
                const Positioned(
                  left: 80,
                  top: 130,
                  child: Icon(Icons.airplanemode_active, size: 24),
                ),
              Positioned(
                right: 10,
                top: 10,
                bottom: 10,
                left: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(10, (index) {
                    int num = 10 - index;
                    bool occupied = isInitial && (num == 5 || num == 9);
                    return Container(
                      height: 25,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12)),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            '$num. Corridor',
                            style: TextStyle(
                              fontSize: 8,
                              color: occupied ? Colors.red : Colors.black,
                              fontWeight: occupied ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          if (occupied) ...[
                            const Expanded(
                              child: Text(
                                ' - - - - - - - ',
                                style: TextStyle(color: Colors.red, fontSize: 8),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.airplanemode_active, size: 14),
                          ],
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ],
    );
  }
}
