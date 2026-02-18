import 'package:get/get.dart';
import 'package:battaglia_navale/models/game_config.dart';
import 'package:battaglia_navale/models/game_state.dart';
import 'package:battaglia_navale/models/board.dart';
import 'package:battaglia_navale/models/ship.dart';
import 'package:battaglia_navale/models/enums.dart';
import 'package:battaglia_navale/services/game_service.dart';
import 'package:battaglia_navale/services/bluetooth_service.dart';

class GameController extends GetxController {
  final gameService = GameService();
  final bluetoothService = BluetoothService();

  final gameState = GameState(timestamp: DateTime.now()).obs;
  final gameConfig = Rxn<GameConfig>();
  final playerBoard = Rxn<Board>();
  final opponentBoard = Rxn<Board>();
  final playerShips = RxList<Ship>();
  final selectedShipIndex = Rxn<int>();
  final isShipsPlaced = false.obs;

  @override
  void onInit() {
    super.onInit();
    bluetoothService.initialize();
    bluetoothService.connectionStatus.listen((connected) {
      if (!connected) {
        gameState.value = gameState.value.copyWith(
          phase: GamePhase.lobby,
          status: GameStatus.disconnected,
        );
      }
    });

    bluetoothService.messages.listen((message) {
      _handleRemoteMessage(message);
    });
  }

  void initializeGame(GameConfig config) {
    gameConfig.value = config;
    gameService.initializeGame(config);
    playerBoard.value = gameService.playerBoard;
    opponentBoard.value = gameService.opponentBoard;
    playerShips.assignAll(gameService.playerShips);
    gameState.value = gameState.value.copyWith(
      phase: GamePhase.setup,
      status: GameStatus.ready,
    );
  }

  void startScanning() {
    bluetoothService.startScanning();
  }

  void stopScanning() {
    bluetoothService.stopScanning();
  }

  Future<void> connectToDevice(String deviceId) async {
    // Implementazione della connessione basata su deviceId
    // Placeholder per ora
  }

  bool canPlaceShip(Ship ship) {
    if (playerBoard.value == null) return false;
    return gameService.canPlaceShip(ship, playerBoard.value!);
  }

  void placeShip(int shipIndex, Ship ship) {
    if (playerBoard.value == null) return;
    
    gameService.placeShip(ship, playerBoard.value!, ship.id);
    playerShips[shipIndex] = ship;
    playerShips.refresh();
  }

  void rotateShip(int shipIndex) {
    if (shipIndex >= playerShips.length) return;
    
    final ship = playerShips[shipIndex];
    final newOrientation = ship.orientation == ShipOrientation.horizontal
        ? ShipOrientation.vertical
        : ShipOrientation.horizontal;
    
    final rotatedShip = ship.copyWith(orientation: newOrientation);
    
    if (gameService.canPlaceShip(rotatedShip, playerBoard.value!)) {
      placeShip(shipIndex, rotatedShip);
    }
  }

  void confirmShipPlacement() {
    isShipsPlaced.value = true;
    gameState.value = gameState.value.copyWith(
      phase: GamePhase.shipPlacement,
      status: GameStatus.ready,
    );

    // Invia il messaggio di posizionamento navi all'avversario
    final message = gameService.createShipPlacementMessage();
    bluetoothService.sendMessage(message.toJson());
  }

  void startGameplay() {
    gameState.value = gameState.value.copyWith(
      phase: GamePhase.gameplay,
      status: GameStatus.yourTurn,
    );
  }

  Future<void> shootAt(int x, int y) async {
    if (gameState.value.status != GameStatus.yourTurn) {
      Get.snackbar('Turno', 'Non è il tuo turno');
      return;
    }

    final result = gameService.recordShot(x, y, gameService.opponentBoard);
    
    if (result == ShotResult.hit) {
      // Aggiorna solo se è un colpo
    } else if (result == ShotResult.alreadyShot) {
      Get.snackbar('Errore', 'Posizione già bersagliata');
      return;
    }

    opponentBoard.refresh();

    final message = gameService.createShotMessage(x, y);
    await bluetoothService.sendMessage(message.toJson());

    gameState.value = gameState.value.copyWith(
      status: GameStatus.opponentTurn,
    );
  }

  void _handleRemoteMessage(String jsonMessage) {
    try {
      final message = GameMessage.fromJson(jsonMessage);

      switch (message.type) {
        case 'config':
          final config = GameConfig(
            gridWidth: message.payload['width'],
            gridHeight: message.payload['height'],
            shipLengths: List<int>.from(message.payload['shipLengths']),
          );
          initializeGame(config);
          break;

        case 'shot':
          final x = message.payload['x'];
          final y = message.payload['y'];
          _handleRemoteShot(x, y);
          break;

        case 'result':
          final x = message.payload['x'];
          final y = message.payload['y'];
          final resultStr = message.payload['result'];
          _handleShotResult(x, y, resultStr);
          break;
      }
    } catch (e) {
      print('Error handling remote message: $e');
    }
  }

  void _handleRemoteShot(int x, int y) {
    final result = gameService.recordShot(x, y, gameService.playerBoard);
    playerBoard.refresh();

    final message = gameService.createResultMessage(x, y, result);
    bluetoothService.sendMessage(message.toJson());

    gameState.value = gameState.value.copyWith(
      status: GameStatus.yourTurn,
    );
  }

  void _handleShotResult(int x, int y, String resultStr) {
    final result = ShotResult.values.firstWhere(
      (e) => e.toString().split('.')[1] == resultStr,
    );

    if (result == ShotResult.hit) {
      print('Colpito!');
    } else if (result == ShotResult.miss) {
      print('Acqua!');
    }

    gameState.value = gameState.value.copyWith(
      status: GameStatus.opponentTurn,
    );
  }

  @override
  void onClose() {
    bluetoothService.dispose();
    super.onClose();
  }
}
