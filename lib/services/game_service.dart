import 'dart:convert';
import 'package:battaglia_navale/models/board.dart';
import 'package:battaglia_navale/models/game_config.dart';
import 'package:battaglia_navale/models/ship.dart';
import 'package:battaglia_navale/models/enums.dart';

// Servizio per la logica di gioco e comunicazione dei messaggi

class GameMessage {
  final String type; // 'config', 'shipPlacement', 'shot', 'result', 'gameOver'
  final Map<String, dynamic> payload;

  GameMessage({required this.type, required this.payload});

  String toJson() => jsonEncode({'type': type, 'payload': payload});

  static GameMessage fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return GameMessage(
      type: data['type'],
      payload: data['payload'],
    );
  }
}

class GameService {
  static final GameService _instance = GameService._internal();

  factory GameService() => _instance;

  GameService._internal();

  late GameConfig gameConfig;
  late Board playerBoard;
  late Board opponentBoard;
  List<Ship> playerShips = [];
  List<Ship> opponentShips = [];

  bool isPlayerTurn = false;
  int playerShipsRemaining = 0;
  int opponentShipsRemaining = 0;

  void initializeGame(GameConfig config) {
    gameConfig = config;
    playerBoard = Board(width: config.gridWidth, height: config.gridHeight);
    opponentBoard = Board(width: config.gridWidth, height: config.gridHeight);
    
    playerShips = config.generateEmptyFleet();
    opponentShips = config.generateEmptyFleet();
    
    playerShipsRemaining = config.totalShips;
    opponentShipsRemaining = config.totalShips;
  }

  bool canPlaceShip(Ship ship, Board board) {
    final cells = ship.getCells();
    
    for (var (x, y) in cells) {
      if (x < 0 || x >= board.width || y < 0 || y >= board.height) {
        return false;
      }
      final cell = board.getCell(x, y);
      if (cell.shipId != null) {
        return false;
      }
    }

    // Controlla se ci sono navi adiacenti
    for (var (x, y) in cells) {
      for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
          if (dx == 0 && dy == 0) continue;
          final adjacentCell = board.getCell(x + dx, y + dy);
          if (adjacentCell.shipId != null) {
            return false;
          }
        }
      }
    }

    return true;
  }

  void placeShip(Ship ship, Board board, String shipId) {
    ship = ship.copyWith(id: shipId);
    final cells = ship.getCells();
    
    for (var (x, y) in cells) {
      final cell = board.getCell(x, y);
      board.setCell(x, y, cell.copyWith(shipId: shipId, state: CellState.ship));
    }
  }

  ShotResult recordShot(int x, int y, Board targetBoard) {
    final cell = targetBoard.getCell(x, y);

    if (cell.isRevealed) {
      return ShotResult.alreadyShot;
    }

    final newCell = cell.copyWith(isRevealed: true);

    if (cell.state == CellState.ship && cell.shipId != null) {
      targetBoard.setCell(x, y, newCell.copyWith(state: CellState.hit));
      return ShotResult.hit;
    } else {
      targetBoard.setCell(x, y, newCell.copyWith(state: CellState.miss));
      return ShotResult.miss;
    }
  }

  bool checkIfShipSunk(String shipId, Board board) {
    int hitCount = board.countHitsByShip(shipId);
    final ship = playerShips.firstWhere((s) => s.id == shipId, orElse: () => Ship(length: 0, x: 0, y: 0));
    return hitCount >= ship.length;
  }

  GameMessage createConfigMessage() {
    return GameMessage(
      type: 'config',
      payload: {
        'width': gameConfig.gridWidth,
        'height': gameConfig.gridHeight,
        'shipLengths': gameConfig.shipLengths,
      },
    );
  }

  GameMessage createShipPlacementMessage() {
    return GameMessage(
      type: 'shipPlacement',
      payload: {
        'ships': playerShips
            .map((ship) => {
                  'id': ship.id,
                  'length': ship.length,
                  'x': ship.x,
                  'y': ship.y,
                  'orientation': ship.orientation == ShipOrientation.horizontal ? 'h' : 'v',
                })
            .toList(),
      },
    );
  }

  GameMessage createShotMessage(int x, int y) {
    return GameMessage(
      type: 'shot',
      payload: {'x': x, 'y': y},
    );
  }

  GameMessage createResultMessage(int x, int y, ShotResult result) {
    return GameMessage(
      type: 'result',
      payload: {
        'x': x,
        'y': y,
        'result': result.toString().split('.')[1],
      },
    );
  }
}
