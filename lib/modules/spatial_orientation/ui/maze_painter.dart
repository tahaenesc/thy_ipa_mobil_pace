import 'package:flutter/material.dart';
import '../models/maze.dart';
import '../models/maze_cell.dart';

enum MazeAxis { none, horizontal, vertical, both }

class MazePainter extends CustomPainter {
  final Maze maze;
  final MazeAxis axis;
  final Offset? ballPosition;
  final bool isActive;
  final bool isBallStandBy;

  MazePainter({
    required this.maze,
    required this.axis,
    this.ballPosition,
    this.isActive = false,
    this.isBallStandBy = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double step = size.width / maze.size;
    
    // Draw background
    final bgPaint = Paint()..color = isActive ? Colors.black : const Color(0xFFC0C0C0);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final wallPaint = Paint()..color = isActive ? Colors.white : Colors.black54;

    for (int y = 0; y < maze.size; y++) {
      for (int x = 0; x < maze.size; x++) {
        final cell = maze.getCell(x, y);
        
        // Compute mirrored coordinates for drawing the "structure"
        // Wait, the Java app mirrors the WHOLE maze structure once.
        int drawX = x;
        int drawY = y;
        
        if (axis == MazeAxis.horizontal) {
          drawX = maze.size - 1 - x;
        } else if (axis == MazeAxis.vertical) {
          drawY = maze.size - 1 - y;
        } else if (axis == MazeAxis.both) {
          drawX = maze.size - 1 - x;
          drawY = maze.size - 1 - y;
        }

        if (cell.isWall) {
          canvas.drawRect(
            Rect.fromLTWH(drawX * step, drawY * step, step, step),
            wallPaint,
          );
        } else if (cell.type == CellType.exit) {
           // Goal (Central empty space)
           final goalPaint = Paint()..color = Colors.green;
           canvas.drawRect(
             Rect.fromLTWH(drawX * step, drawY * step, step, step),
             goalPaint,
           );
        }
      }
    }

    // Draw Ball if provided
    if (ballPosition != null) {
      final ballPaint = Paint()..color = isBallStandBy ? Colors.blue : Colors.red;
      
      int bx = ballPosition!.dx.toInt();
      int by = ballPosition!.dy.toInt();
      
      int dbx = bx;
      int dby = by;
      
      if (axis == MazeAxis.horizontal) {
        dbx = maze.size - 1 - bx;
      } else if (axis == MazeAxis.vertical) {
        dby = maze.size - 1 - by;
      } else if (axis == MazeAxis.both) {
        dbx = maze.size - 1 - bx;
        dby = maze.size - 1 - by;
      }

      canvas.drawOval(
        Rect.fromLTWH(dbx * step, dby * step, step, step),
        ballPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MazePainter oldDelegate) {
    return oldDelegate.ballPosition != ballPosition ||
           oldDelegate.isActive != isActive ||
           oldDelegate.isBallStandBy != isBallStandBy;
  }
}
