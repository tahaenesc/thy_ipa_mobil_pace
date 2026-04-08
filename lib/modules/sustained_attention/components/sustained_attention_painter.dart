import 'package:flutter/material.dart';

enum SustainedAttentionLineType { vertical, horizontal, black, none }

class SustainedAttentionCircle {
  double x; // 0.0 to 1.0 (relative to display area)
  double y; // 0.0 to 1.0 (relative to display area)
  final Color color;
  final bool isRed;
  bool reachedCenter = false;
  bool readyToExit = false;
  bool exited = false;
  bool reacted = false;

  SustainedAttentionCircle({
    required this.x,
    required this.y,
    required this.color,
    required this.isRed,
  });
}

class SustainedAttentionPainter extends CustomPainter {
  final List<SustainedAttentionCircle> circles;
  final SustainedAttentionLineType lineType;
  final Color? lineColor;

  SustainedAttentionPainter({
    required this.circles,
    required this.lineType,
    this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Draw background (gray area)
    paint.color = const Color(0xFFD9D9D9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ),
      paint,
    );

    // Draw active line
    if (lineType != SustainedAttentionLineType.none) {
      final linePaint = Paint()
        ..color = lineColor ?? Colors.black
        ..strokeWidth = 3;

      if (lineType == SustainedAttentionLineType.vertical) {
        canvas.drawLine(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          linePaint,
        );
      } else if (lineType == SustainedAttentionLineType.horizontal) {
        canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(size.width, size.height / 2),
          linePaint,
        );
      } else if (lineType == SustainedAttentionLineType.black) {
        linePaint.color = Colors.black;
        canvas.drawLine(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          linePaint,
        );
      }
    }

    // Draw circles
    for (var circle in circles) {
      if (circle.exited) continue;
      
      paint.color = circle.color;
      canvas.drawCircle(
        Offset(circle.x * size.width, circle.y * size.height),
        15,
        paint,
      );
    }
    
    // Draw border
    final borderPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant SustainedAttentionPainter oldDelegate) {
    return true; // Simple approach for animation
  }
}
