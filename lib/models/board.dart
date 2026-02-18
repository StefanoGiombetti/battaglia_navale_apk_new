enum CellState { empty, ship, hit, miss, sunk }

class Cell {
  CellState state;
  int? shipId;
  bool isRevealed;

  Cell({
    this.state = CellState.empty,
    this.shipId,
    this.isRevealed = false,
  });

  Cell copyWith({
    CellState? state,
    int? shipId,
    bool? isRevealed,
  }) {
    return Cell(
      state: state ?? this.state,
      shipId: shipId ?? this.shipId,
      isRevealed: isRevealed ?? this.isRevealed,
    );
  }
}

class Board {
  final int width;
  final int height;
  late List<List<Cell>> grid;

  Board({required this.width, required this.height}) {
    _initializeGrid();
  }

  void _initializeGrid() {
    grid = List.generate(
      height,
      (y) => List.generate(width, (x) => Cell()),
    );
  }

  Cell getCell(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) {
      return Cell(state: CellState.empty);
    }
    return grid[y][x];
  }

  void setCell(int x, int y, Cell cell) {
    if (x >= 0 && x < width && y >= 0 && y < height) {
      grid[y][x] = cell;
    }
  }

  int countHitsByShip(int shipId) {
    int count = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (grid[y][x].shipId == shipId && 
            (grid[y][x].state == CellState.hit || grid[y][x].state == CellState.sunk)) {
          count++;
        }
      }
    }
    return count;
  }

  void reset() {
    _initializeGrid();
  }
}
