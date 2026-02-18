import 'package:uuid/uuid.dart';

enum ShipOrientation { horizontal, vertical }

class Ship {
  final String id;
  final int length;
  int x;
  int y;
  ShipOrientation orientation;
  int hitCount = 0;

  Ship({
    String? id,
    required this.length,
    required this.x,
    required this.y,
    this.orientation = ShipOrientation.horizontal,
  }) : id = id ?? const Uuid().v4();

  bool isSunk(int shipHitCount) => shipHitCount >= length;

  bool containsCell(int cellX, int cellY) {
    if (orientation == ShipOrientation.horizontal) {
      return cellY == y && cellX >= x && cellX < x + length;
    } else {
      return cellX == x && cellY >= y && cellY < y + length;
    }
  }

  List<(int, int)> getCells() {
    List<(int, int)> cells = [];
    if (orientation == ShipOrientation.horizontal) {
      for (int i = 0; i < length; i++) {
        cells.add((x + i, y));
      }
    } else {
      for (int i = 0; i < length; i++) {
        cells.add((x, y + i));
      }
    }
    return cells;
  }

  Ship copyWith({
    String? id,
    int? length,
    int? x,
    int? y,
    ShipOrientation? orientation,
    int? hitCount,
  }) {
    return Ship(
      id: id ?? this.id,
      length: length ?? this.length,
      x: x ?? this.x,
      y: y ?? this.y,
      orientation: orientation ?? this.orientation,
    )..hitCount = hitCount ?? this.hitCount;
  }
}
