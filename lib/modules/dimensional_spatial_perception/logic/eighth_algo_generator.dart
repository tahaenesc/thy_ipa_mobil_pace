import '../models/house_model.dart';

class EighthAlgoGenerator {
  List<QuestionSet> generateQuestions() {
    final List<QuestionSet> sets = [];

    // Question 1
    sets.add(QuestionSet(
      houseIndex: 1,
      houseType: HouseType.single,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set0,
      q1Side: HouseSide.frontLeft, q1Angle: 0, q1Name: 'single/single_6/front_left.svg',
      q2Side: HouseSide.backLeft, q2Angle: 0, q2Name: 'single/single_6/back_left.svg',
      a1Side: HouseSide.frontRight, a1Angle: 90, a1Name: 'single/single_6/front_right.svg', a1IsAns: true,
      a2Side: HouseSide.backLeft, a2Angle: 180, a2Name: 'single/single_6_fake/back_left.svg', a2IsAns: false,
      a3Side: HouseSide.backRight, a3Angle: 0, a3Name: 'single/single_6_fake/back_right.svg', a3IsAns: false,
      a4Side: HouseSide.frontLeft, a4Angle: 270, a4Name: 'single/single_6_fake/front_left.svg', a4IsAns: false,
    ));

    // Question 2
    sets.add(QuestionSet(
      houseIndex: 2,
      houseType: HouseType.single,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set2,
      q1Side: HouseSide.frontRight, q1Angle: 0, q1Name: 'single/single_7/front_right.svg',
      q2Side: HouseSide.backRight, q2Angle: 0, q2Name: 'single/single_7/back_right.svg',
      a1Side: HouseSide.frontRight, a1Angle: 180, a1Name: 'single/single_7_fake/front_right.svg', a1IsAns: false,
      a2Side: HouseSide.backLeft, a2Angle: 270, a2Name: 'single/single_7/back_left.svg', a2IsAns: true,
      a3Side: HouseSide.backRight, a3Angle: 0, a3Name: 'single/single_7_fake/back_right.svg', a3IsAns: false,
      a4Side: HouseSide.frontLeft, a4Angle: 90, a4Name: 'single/single_7_fake/front_left.svg', a4IsAns: false,
    ));

    // Question 3
    sets.add(QuestionSet(
      houseIndex: 3,
      houseType: HouseType.single,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set2,
      q1Side: HouseSide.frontLeft, q1Angle: 0, q1Name: 'single/single_4/front_left.svg',
      q2Side: HouseSide.backLeft, q2Angle: 0, q2Name: 'single/single_4/back_left.svg',
      a1Side: HouseSide.frontLeft, a1Angle: 0, a1Name: 'single/single_4_fake/front_left.svg', a1IsAns: false,
      a2Side: HouseSide.backRight, a2Angle: 270, a2Name: 'single/single_4_fake/back_right.svg', a2IsAns: false,
      a3Side: HouseSide.backLeft, a3Angle: 90, a3Name: 'single/single_4_fake/back_left.svg', a3IsAns: false,
      a4Side: HouseSide.frontRight, a4Angle: 180, a4Name: 'single/single_4/front_right.svg', a4IsAns: true,
    ));

    // Question 4
    sets.add(QuestionSet(
      houseIndex: 4,
      houseType: HouseType.single,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set0,
      q1Side: HouseSide.frontLeft, q1Angle: 0, q1Name: 'single/single_3/front_left.svg',
      q2Side: HouseSide.backLeft, q2Angle: 0, q2Name: 'single/single_3/back_left.svg',
      a1Side: HouseSide.frontRight, a1Angle: 90, a1Name: 'single/single_3/front_right.svg', a1IsAns: true,
      a2Side: HouseSide.backRight, a2Angle: 0, a2Name: 'single/single_3_fake/back_right.svg', a2IsAns: false,
      a3Side: HouseSide.backLeft, a3Angle: 180, a3Name: 'single/single_3_fake/back_left.svg', a3IsAns: false,
      a4Side: HouseSide.frontLeft, a4Angle: 270, a4Name: 'single/single_3_fake/front_left.svg', a4IsAns: false,
    ));

    // Question 5
    sets.add(QuestionSet(
      houseIndex: 5,
      houseType: HouseType.single,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set2,
      q1Side: HouseSide.frontRight, q1Angle: 0, q1Name: 'single/single_5/front_right.svg',
      q2Side: HouseSide.backRight, q2Angle: 0, q2Name: 'single/single_5/back_right.svg',
      a1Side: HouseSide.backRight, a1Angle: 180, a1Name: 'single/single_5_fake/back_right.svg', a1IsAns: false,
      a2Side: HouseSide.backLeft, a2Angle: 270, a2Name: 'single/single_5_fake/back_left.svg', a2IsAns: false,
      a3Side: HouseSide.frontRight, a3Angle: 0, a3Name: 'single/single_5_fake/front_right.svg', a3IsAns: false,
      a4Side: HouseSide.frontLeft, a4Angle: 90, a4Name: 'single/single_5/front_left.svg', a4IsAns: true,
    ));

    // Question 6
    sets.add(QuestionSet(
      houseIndex: 6,
      houseType: HouseType.double,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set0,
      q1Side: HouseSide.frontLeft, q1Angle: 0, q1Name: 'double/double_6/front_left.svg',
      q2Side: HouseSide.backLeft, q2Angle: 0, q2Name: 'double/double_6/back_left.svg',
      a1Side: HouseSide.backLeft, a1Angle: 90, a1Name: 'double/double_6_fake/back_left.svg', a1IsAns: false,
      a2Side: HouseSide.frontRight, a2Angle: 180, a2Name: 'double/double_6_fake/front_right.svg', a2IsAns: false,
      a3Side: HouseSide.backRight, a3Angle: 0, a3Name: 'double/double_6/back_right.svg', a3IsAns: true,
      a4Side: HouseSide.frontLeft, a4Angle: 270, a4Name: 'double/double_6_fake/front_left.svg', a4IsAns: false,
    ));

    // Question 7
    sets.add(QuestionSet(
      houseIndex: 7,
      houseType: HouseType.double,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set2,
      q1Side: HouseSide.frontRight, q1Angle: 0, q1Name: 'double/double_7/front_right.svg',
      q2Side: HouseSide.backRight, q2Angle: 0, q2Name: 'double/double_7/back_right.svg',
      a1Side: HouseSide.backRight, a1Angle: 270, a1Name: 'double/double_7_fake/back_right.svg', a1IsAns: false,
      a2Side: HouseSide.backLeft, a2Angle: 0, a2Name: 'double/double_7/back_left.svg', a2IsAns: true,
      a3Side: HouseSide.frontRight, a3Angle: 90, a3Name: 'double/double_7_fake/front_right.svg', a3IsAns: false,
      a4Side: HouseSide.frontLeft, a4Angle: 180, a4Name: 'double/double_7_fake/front_left.svg', a4IsAns: false,
    ));

    // Question 8
    sets.add(QuestionSet(
      houseIndex: 8,
      houseType: HouseType.double,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set2,
      q1Side: HouseSide.frontLeft, q1Angle: 0, q1Name: 'double/double_5/front_left.svg',
      q2Side: HouseSide.backLeft, q2Angle: 0, q2Name: 'double/double_5/back_left.svg',
      a1Side: HouseSide.frontLeft, a1Angle: 180, a1Name: 'double/double_5_fake/front_left.svg', a1IsAns: false,
      a2Side: HouseSide.backRight, a2Angle: 270, a2Name: 'double/double_5/back_right.svg', a2IsAns: true,
      a3Side: HouseSide.backLeft, a3Angle: 0, a3Name: 'double/double_5_fake/back_left.svg', a3IsAns: false,
      a4Side: HouseSide.frontRight, a4Angle: 90, a4Name: 'double/double_5_fake/front_right.svg', a4IsAns: false,
    ));

    // Question 9
    sets.add(QuestionSet(
      houseIndex: 9,
      houseType: HouseType.double,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set2,
      q1Side: HouseSide.frontRight, q1Angle: 0, q1Name: 'double/double_3/front_right.svg',
      q2Side: HouseSide.backRight, q2Angle: 0, q2Name: 'double/double_3/back_right.svg',
      a1Side: HouseSide.frontRight, a1Angle: 180, a1Name: 'double/double_3_fake/front_right.svg', a1IsAns: false,
      a2Side: HouseSide.backRight, a2Angle: 90, a2Name: 'double/double_3_fake/back_right.svg', a2IsAns: false,
      a3Side: HouseSide.backLeft, a3Angle: 0, a3Name: 'double/double_3_fake/back_left.svg', a3IsAns: false,
      a4Side: HouseSide.frontLeft, a4Angle: 270, a4Name: 'double/double_3/front_left.svg', a4IsAns: true,
    ));

    // Question 10
    sets.add(QuestionSet(
      houseIndex: 10,
      houseType: HouseType.double,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set0,
      q1Side: HouseSide.frontRight, q1Angle: 0, q1Name: 'double/double_4/front_right.svg',
      q2Side: HouseSide.backRight, q2Angle: 0, q2Name: 'double/double_4/back_right.svg',
      a1Side: HouseSide.backLeft, a1Angle: 180, a1Name: 'double/double_4/back_left.svg', a1IsAns: true,
      a2Side: HouseSide.frontRight, a2Angle: 270, a2Name: 'double/double_4_fake/front_right.svg', a2IsAns: false,
      a3Side: HouseSide.frontLeft, a3Angle: 0, a3Name: 'double/double_4_fake/front_left.svg', a3IsAns: false,
      a4Side: HouseSide.backRight, a4Angle: 90, a4Name: 'double/double_4_fake/back_right.svg', a4IsAns: false,
    ));

    // Question 11
    sets.add(QuestionSet(
      houseIndex: 11,
      houseType: HouseType.triple,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set0,
      q1Side: HouseSide.frontLeft, q1Angle: 0, q1Name: 'triple/triple_6/front_left.svg',
      q2Side: HouseSide.backLeft, q2Angle: 0, q2Name: 'triple/triple_6/back_left.svg',
      a1Side: HouseSide.frontRight, a1Angle: 90, a1Name: 'triple/triple_6_fake/front_right.svg', a1IsAns: false,
      a2Side: HouseSide.backLeft, a2Angle: 0, a2Name: 'triple/triple_6_fake/back_left.svg', a2IsAns: false,
      a3Side: HouseSide.frontLeft, a3Angle: 270, a3Name: 'triple/triple_6_fake/front_left.svg', a3IsAns: false,
      a4Side: HouseSide.backRight, a4Angle: 180, a4Name: 'triple/triple_6/back_right.svg', a4IsAns: true,
    ));

    // Question 12
    sets.add(QuestionSet(
      houseIndex: 12,
      houseType: HouseType.triple,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set2,
      q1Side: HouseSide.frontLeft, q1Angle: 0, q1Name: 'triple/triple_7/front_left.svg',
      q2Side: HouseSide.backLeft, q2Angle: 0, q2Name: 'triple/triple_7/back_left.svg',
      a1Side: HouseSide.backRight, a1Angle: 180, a1Name: 'triple/triple_7/back_right.svg', a1IsAns: true,
      a2Side: HouseSide.backLeft, a2Angle: 90, a2Name: 'triple/triple_7_fake/back_left.svg', a2IsAns: false,
      a3Side: HouseSide.frontLeft, a3Angle: 0, a3Name: 'triple/triple_7_fake/front_left.svg', a3IsAns: false,
      a4Side: HouseSide.frontRight, a4Angle: 270, a4Name: 'triple/triple_7_fake/front_right.svg', a4IsAns: false,
    ));

    // Question 13
    sets.add(QuestionSet(
      houseIndex: 13,
      houseType: HouseType.triple,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set0,
      q1Side: HouseSide.frontRight, q1Angle: 0, q1Name: 'triple/triple_3/front_right.svg',
      q2Side: HouseSide.backRight, q2Angle: 0, q2Name: 'triple/triple_3/back_right.svg',
      a1Side: HouseSide.backRight, a1Angle: 0, a1Name: 'triple/triple_3_fake/back_right.svg', a1IsAns: false,
      a2Side: HouseSide.frontRight, a2Angle: 90, a2Name: 'triple/triple_3_fake/front_right.svg', a2IsAns: false,
      a3Side: HouseSide.frontLeft, a3Angle: 270, a3Name: 'triple/triple_3/front_left.svg', a3IsAns: true,
      a4Side: HouseSide.backLeft, a4Angle: 180, a4Name: 'triple/triple_3_fake/back_left.svg', a4IsAns: false,
    ));

    // Question 14
    sets.add(QuestionSet(
      houseIndex: 14,
      houseType: HouseType.triple,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set2,
      q1Side: HouseSide.frontRight, q1Angle: 0, q1Name: 'triple/triple_4/front_right.svg',
      q2Side: HouseSide.backRight, q2Angle: 0, q2Name: 'triple/triple_4/back_right.svg',
      a1Side: HouseSide.backRight, a1Angle: 90, a1Name: 'triple/triple_4_fake/back_right.svg', a1IsAns: false,
      a2Side: HouseSide.frontRight, a2Angle: 0, a2Name: 'triple/triple_4_fake/front_right.svg', a2IsAns: false,
      a3Side: HouseSide.backLeft, a3Angle: 270, a3Name: 'triple/triple_4/back_left.svg', a3IsAns: true,
      a4Side: HouseSide.frontLeft, a4Angle: 180, a4Name: 'triple/triple_4_fake/front_left.svg', a4IsAns: false,
    ));

    // Question 15
    sets.add(QuestionSet(
      houseIndex: 15,
      houseType: HouseType.triple,
      rightWindow: true,
      leftWindow: true,
      chimney: true,
      colorPalette: ColorPalette.set0,
      q1Side: HouseSide.frontRight, q1Angle: 0, q1Name: 'triple/triple_5/front_right.svg',
      q2Side: HouseSide.backRight, q2Angle: 0, q2Name: 'triple/triple_5/back_right.svg',
      a1Side: HouseSide.frontLeft, a1Angle: 270, a1Name: 'triple/triple_5/front_left.svg', a1IsAns: true,
      a2Side: HouseSide.backRight, a2Angle: 90, a2Name: 'triple/triple_5_fake/back_right.svg', a2IsAns: false,
      a3Side: HouseSide.frontRight, a3Angle: 180, a3Name: 'triple/triple_5_fake/front_right.svg', a3IsAns: false,
      a4Side: HouseSide.backLeft, a4Angle: 0, a4Name: 'triple/triple_5_fake/back_left.svg', a4IsAns: false,
    ));

    return sets;
  }
}

class QuestionSet {
  final int houseIndex;
  final HouseType houseType;
  final bool rightWindow;
  final bool leftWindow;
  final bool chimney;
  final ColorPalette colorPalette;

  final HouseSide q1Side;
  final int q1Angle;
  final String q1Name;

  final HouseSide q2Side;
  final int q2Angle;
  final String q2Name;

  final HouseSide a1Side;
  final int a1Angle;
  final String a1Name;
  final bool a1IsAns;

  final HouseSide a2Side;
  final int a2Angle;
  final String a2Name;
  final bool a2IsAns;

  final HouseSide a3Side;
  final int a3Angle;
  final String a3Name;
  final bool a3IsAns;

  final HouseSide a4Side;
  final int a4Angle;
  final String a4Name;
  final bool a4IsAns;

  QuestionSet({
    required this.houseIndex,
    required this.houseType,
    required this.rightWindow,
    required this.leftWindow,
    required this.chimney,
    required this.colorPalette,
    required this.q1Side, required this.q1Angle, required this.q1Name,
    required this.q2Side, required this.q2Angle, required this.q2Name,
    required this.a1Side, required this.a1Angle, required this.a1Name, required this.a1IsAns,
    required this.a2Side, required this.a2Angle, required this.a2Name, required this.a2IsAns,
    required this.a3Side, required this.a3Angle, required this.a3Name, required this.a3IsAns,
    required this.a4Side, required this.a4Angle, required this.a4Name, required this.a4IsAns,
  });

  List<House> toHouseList() {
    final base = House(
      houseIndex: houseIndex,
      houseType: houseType,
      rightWindow: rightWindow,
      leftWindow: leftWindow,
      chimney: chimney,
      colorPalette: colorPalette,
      name: '', // Will be set per house
      rotationAngle: 0,
    );

    return [
      base.copyWith(houseSide: q1Side, rotationAngle: q1Angle, name: q1Name),
      base.copyWith(houseSide: q2Side, rotationAngle: q2Angle, name: q2Name),
      base.copyWith(houseSide: a1Side, rotationAngle: a1Angle, name: a1Name, isAnswer: a1IsAns),
      base.copyWith(houseSide: a2Side, rotationAngle: a2Angle, name: a2Name, isAnswer: a2IsAns),
      base.copyWith(houseSide: a3Side, rotationAngle: a3Angle, name: a3Name, isAnswer: a3IsAns),
      base.copyWith(houseSide: a4Side, rotationAngle: a4Angle, name: a4Name, isAnswer: a4IsAns),
    ];
  }
}
