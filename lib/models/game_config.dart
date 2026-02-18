import 'ship.dart';

class GameConfig {
  final int gridWidth;
  final int gridHeight;
  final List<int> shipLengths;

  const GameConfig({
    required this.gridWidth,
    required this.gridHeight,
    required this.shipLengths,
  });

  static GameConfig getClassicPreset() {
    return const GameConfig(
      gridWidth: 10,
      gridHeight: 10,
      shipLengths: [5, 4, 3, 3, 2],
    );
  }

  int get totalShips => shipLengths.length;
  int get totalShipCells => shipLengths.fold(0, (sum, length) => sum + length);

  List<Ship> generateEmptyFleet() {
    List<Ship> ships = [];
    for (int length in shipLengths) {
      ships.add(Ship(length: length, x: 0, y: 0));
    }
    return ships;
  }
}
