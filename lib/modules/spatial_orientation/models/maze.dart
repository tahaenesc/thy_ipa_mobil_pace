import 'maze_cell.dart';

class Maze {
  final int size;
  final List<List<MazeCell>> grid;

  Maze(this.size, this.grid);

  MazeCell getCell(int x, int y) {
    if (x < 0 || x >= size || y < 0 || y >= size) return MazeCell(x, y, CellType.wall);
    return grid[y][x];
  }
}
