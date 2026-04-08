enum CellType {
  wall,
  passage,
  escape,
  ball,
  entry,
  exit,
}

class MazeCell {
  final int x;
  final int y;
  CellType type;

  MazeCell(this.x, this.y, this.type);

  bool get isWall => type == CellType.wall;
  bool get isEscape => type == CellType.escape;
  bool get isPassage => type == CellType.passage;
}
