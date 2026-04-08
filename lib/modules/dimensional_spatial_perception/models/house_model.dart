enum HouseSide {
  frontLeft,
  frontRight,
  backLeft,
  backRight;

  String get fileName {
    switch (this) {
      case HouseSide.frontLeft:
        return 'front_left.svg';
      case HouseSide.frontRight:
        return 'front_right.svg';
      case HouseSide.backLeft:
        return 'back_left.svg';
      case HouseSide.backRight:
        return 'back_right.svg';
    }
  }
}

enum HouseType {
  single,
  double,
  triple;

  String get folderName {
    switch (this) {
      case HouseType.single:
        return 'single';
      case HouseType.double:
        return 'double';
      case HouseType.triple:
        return 'triple';
    }
  }
}

enum ColorPalette {
  set0(['8F6645', 'EEEEEE', 'DDDDDD', '3D3A37', 'C4C4C4', '3D3A37', '000000', 'FFFFFF', '888888', '7884AF']),
  set1(['8F6645', 'F5DEB3', 'DDDDDD', '3D3A37', '3D3A37', 'C4C4C4', '000000', '800000', '888888', 'C0C0C0']),
  set2(['3D3A37', 'EEEEEE', 'DDDDDD', '8F6645', '708090', '3D3A37', '000000', 'FFFFFF', 'DEB887', '7884AF']),
  set3(['8F6645', 'F5DEB3', '0F0F0F', 'C0C0C0', 'D2B48C', '3D3A37', '000000', 'F5F5F5', '5E2605', '87CEFA']),
  set4(['8F6645', 'F5DEB3', 'D2B48C', 'DEB887', '8B4513', 'CD853F', '000000', 'F5F5F5', '5E2605', '87CEFA']),
  set5(['6F757A', 'EFE9E5', 'FFFFFF', 'C70A0C', 'FBAB18', '6F757A', '000000', 'FFFFFF', '5553A5', 'B9CFED']),
  set6(['A52A2A', 'C0C0C0', '959595', 'A9A9A9', '2F4F4F', '696969', '708090', '696969', 'CDB79E', '5F9EA0']),
  set7(['8B4513', '778899', '2F4F4F', '2F4F4F', '222222', '222222', '708090', '708090', 'C70A0C', 'ADD8E6']),
  set8(['8B4513', 'F5DEB3', 'FFFFFF', 'A0522D', 'C70A0C', '8B4513', '000000', 'FFFFFF', '555555', '0053A5']);

  final List<String> colors;
  const ColorPalette(this.colors);

  String getColor(int index) {
    if (index >= 0 && index < colors.length) {
      return colors[index];
    }
    return '000000';
  }
}

class House {
  final int houseIndex;
  final HouseSide? houseSide;
  final HouseType houseType;
  final String name;
  final bool rightWindow;
  final bool leftWindow;
  final bool chimney;
  final int rotationAngle;
  final ColorPalette colorPalette;
  final bool isAnswer;

  House({
    required this.houseIndex,
    this.houseSide,
    required this.houseType,
    required this.name,
    required this.rightWindow,
    required this.leftWindow,
    required this.chimney,
    required this.rotationAngle,
    required this.colorPalette,
    this.isAnswer = false,
  });

  House copyWith({
    int? houseIndex,
    HouseSide? houseSide,
    HouseType? houseType,
    String? name,
    bool? rightWindow,
    bool? leftWindow,
    bool? chimney,
    int? rotationAngle,
    ColorPalette? colorPalette,
    bool? isAnswer,
  }) {
    return House(
      houseIndex: houseIndex ?? this.houseIndex,
      houseSide: houseSide ?? this.houseSide,
      houseType: houseType ?? this.houseType,
      name: name ?? this.name,
      rightWindow: rightWindow ?? this.rightWindow,
      leftWindow: leftWindow ?? this.leftWindow,
      chimney: chimney ?? this.chimney,
      rotationAngle: rotationAngle ?? this.rotationAngle,
      colorPalette: colorPalette ?? this.colorPalette,
      isAnswer: isAnswer ?? this.isAnswer,
    );
  }
}
