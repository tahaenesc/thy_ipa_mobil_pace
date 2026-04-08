import 'package:flutter/material.dart';

enum AgilityShapeType { circle, square }
enum AgilityColor { red, green }

class AgilityShape {
  final AgilityShapeType type;
  final AgilityColor color;
  double y; // 0.0 to 1.0 (relative to container height)
  final double x; // 0.0 to 1.0 (relative to container width)
  final double speed; // change in y per second
  final bool movingUp;
  bool reagted = false;

  AgilityShape({
    required this.type,
    required this.color,
    required this.y,
    required this.x,
    required this.speed,
    required this.movingUp,
  });
}

class AgilityShapePainter extends CustomPainter {
  final List<AgilityShape> shapes;
  final double reactionAreaTop;
  final double reactionAreaBottom;

  AgilityShapePainter({
    required this.shapes,
    required this.reactionAreaTop,
    required this.reactionAreaBottom,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background/reaction area if needed? 
    // Actually the reaction area is better drawn as a widget to be layered.
    
    for (var shape in shapes) {
      final paint = Paint()
        ..color = shape.color == AgilityColor.red ? Colors.red : Colors.green
        ..style = PaintingStyle.fill;

      final center = Offset(shape.x * size.width, shape.y * size.height);
      const radius = 25.0;

      if (shape.type == AgilityShapeType.circle) {
        canvas.drawCircle(center, radius, paint);
      } else {
        canvas.drawRect(
          Rect.fromCenter(center: center, width: radius * 2, height: radius * 2),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
