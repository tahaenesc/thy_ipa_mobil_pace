class DigitSequence {
  final List<int> numbers;
  final List<int> rememberedIndexes;

  DigitSequence({required this.numbers, required this.rememberedIndexes});

  List<int> get targetSequence {
    return rememberedIndexes.map((i) => numbers[i]).toList();
  }
}

class DigitSpanService {
  static final List<DigitSequence> sequences = [
    DigitSequence(numbers: [2, 4, 1, 9, 0, 4], rememberedIndexes: [0, 1, 3, 5]),
    DigitSequence(numbers: [5, 6, 0, 3, 5, 2], rememberedIndexes: [0, 1, 3, 4]),
    DigitSequence(numbers: [6, 0, 3, 1, 7, 9], rememberedIndexes: [0, 2, 4, 5]),
    DigitSequence(numbers: [1, 4, 1, 8, 0, 2], rememberedIndexes: [0, 1, 3, 5]),
    DigitSequence(numbers: [3, 1, 0, 4, 7, 8], rememberedIndexes: [0, 3, 4, 5]),
    // ... more sequences can be added from the Java source
  ];

  static DigitSequence getSequence(int index) {
    if (index < 0 || index >= sequences.length) return sequences[0];
    return sequences[index];
  }
}
