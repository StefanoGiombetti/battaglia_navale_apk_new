import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:battaglia_navale/controllers/game_controller.dart';
import 'package:battaglia_navale/widgets/board_widget.dart';
import 'package:battaglia_navale/models/enums.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({Key? key}) : super(key: key);

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late GameController gameController;

  @override
  void initState() {
    super.initState();
    gameController = Get.find<GameController>();
    gameController.startGameplay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5ED),
      appBar: AppBar(
        title: const Text('Battaglia Navale'),
        backgroundColor: const Color(0xFF8B7355),
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () {
          final state = gameController.gameState.value;
          final playerBoard = gameController.playerBoard.value;
          final opponentBoard = gameController.opponentBoard.value;

          if (playerBoard == null || opponentBoard == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Stato del gioco
              Container(
                color: const Color(0xFF8B7355),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.status == GameStatus.yourTurn ? '🔴 TUO TURNO' : '⚪ TURNO AVVERSARIO',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${gameController.playerShipsRemaining} vs ${gameController.opponentShipsRemaining}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Griglie di gioco
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Griglia del giocatore (sinistra)
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'La mia Griglia',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF8B7355),
                                    width: 2,
                                  ),
                                ),
                                child: BoardWidget(
                                  board: playerBoard,
                                  isOpponentBoard: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Griglia dell'avversario (destra)
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "Griglia Avversaria",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF8B7355),
                                    width: 2,
                                  ),
                                ),
                                child: BoardWidget(
                                  board: opponentBoard,
                                  isOpponentBoard: true,
                                  onCellTapped: state.status == GameStatus.yourTurn
                                      ? (x, y) {
                                          gameController.shootAt(x, y);
                                        }
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Footer
              Container(
                color: const Color(0xFF8B7355),
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    state.status == GameStatus.won
                        ? '🎉 HAI VINTO! 🎉'
                        : state.status == GameStatus.lost
                            ? '☠️ HAI PERSO ☠️'
                            : 'Tocca la griglia dell\'avversario per sparare',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
