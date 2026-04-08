import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/house_model.dart';
import '../logic/house_svg_processor.dart';

class HouseView extends StatelessWidget {
  final House house;
  final double? width;
  final double? height;

  const HouseView({
    super.key,
    required this.house,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: HouseSvgProcessor.processSvg(house),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Icon(Icons.error));
        }
        
        final svgString = snapshot.data!;
        
        return Transform.rotate(
          angle: house.rotationAngle * (3.1415926535897932 / 180),
          child: SvgPicture.string(
            svgString,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
