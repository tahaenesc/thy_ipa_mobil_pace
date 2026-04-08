import 'dart:math';
import '../models/maze.dart';
import '../models/maze_cell.dart';

class MazeGenerator {
  final Random _random = Random();

  Maze generate(int size) {
    // 1. Initialize grid with walls
    List<List<MazeCell>> grid = List.generate(
      size,
      (y) => List.generate(size, (x) => MazeCell(x, y, CellType.wall)),
    );

    // 2. Define logical cells (only odd coordinates)
    // For size 15, logical cells are at (1,1), (1,3), ..., (13,13) -> 7x7 logical grid
    int logicalWidth = (size - 1) ~/ 2;
    int logicalHeight = (size - 1) ~/ 2;

    for (int y = 0; y < logicalHeight; y++) {
      for (int x = 0; x < logicalWidth; x++) {
        grid[y * 2 + 1][x * 2 + 1].type = CellType.passage;
      }
    }

    // 3. Create edges between adjacent logical cells
    List<_Edge> edges = [];
    for (int y = 0; y < logicalHeight; y++) {
      for (int x = 0; x < logicalWidth; x++) {
        if (x < logicalWidth - 1) {
          edges.add(_Edge(_Point(x, y), _Point(x + 1, y)));
        }
        if (y < logicalHeight - 1) {
          edges.add(_Edge(_Point(x, y), _Point(x, y + 1)));
        }
      }
    }

    edges.shuffle(_random);

    // 4. Randomized Kruskal's to build a spanning tree
    _DisjointSet ds = _DisjointSet(logicalWidth * logicalHeight);
    for (var edge in edges) {
      int u = edge.p1.y * logicalWidth + edge.p1.x;
      int v = edge.p2.y * logicalWidth + edge.p2.x;

      if (ds.find(u) != ds.find(v)) {
        ds.union(u, v);
        // Break the wall between them
        int wallX = edge.p1.x + edge.p2.x + 1;
        int wallY = edge.p1.y + edge.p2.y + 1;
        grid[wallY][wallX].type = CellType.passage;
      }
    }

    // Special cells (as per Java code)
    // Entrance: (1, 0)
    grid[0][1].type = CellType.entry;
    
    // Exit: at the bottom-right corner to meet in the center
    // Let's use (size-2, size-1) as the exit passage
    int exitCol = size - 2;
    int exitRow = size - 1;
    grid[exitRow][exitCol].type = CellType.exit;
    grid[exitRow-1][exitCol].type = CellType.passage; // Ensure reachability

    return Maze(size, grid);
  }
}

class _Point {
  final int x, y;
  _Point(this.x, this.y);
}

class _Edge {
  final _Point p1, p2;
  _Edge(this.p1, this.p2);
}

class _DisjointSet {
  final List<int> parent;
  _DisjointSet(int n) : parent = List.generate(n, (i) => i);

  int find(int i) {
    if (parent[i] == i) return i;
    return parent[i] = find(parent[i]);
  }

  void union(int i, int j) {
    int rootI = find(i);
    int rootJ = find(j);
    if (rootI != rootJ) {
      parent[rootI] = rootJ;
    }
  }
}
