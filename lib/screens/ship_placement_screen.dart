import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:battaglia_navale/controllers/game_controller.dart';
import 'package:battaglia_navale/widgets/ship_placement_widget.dart';
import 'package:battaglia_navale/models/ship.dart';

class ShipPlacementScreen extends StatefulWidget {
  const ShipPlacementScreen({Key? key}) : super(key: key);

  @override
  State<ShipPlacementScreen> createState() => _ShipPlacementScreenState();
}

class _ShipPlacementScreenState extends State<ShipPlacementScreen> {
  late GameController gameController;

  @override
  void initState() {
    super.initState();
    gameController = Get.find<GameController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5ED),
      appBar: AppBar(
        title: const Text('Posiziona le Navi'),
        backgroundColor: const Color(0xFF8B7355),
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: gameController.playerBoard.value != null
                    ? ShipPlacementWidget(
                        board: gameController.playerBoard.value!,
                        onTapMove: (x, y) {
                          final selectedIndex = gameController.selectedShipIndex.value;
                          if (selectedIndex != null && selectedIndex < gameController.playerShips.length) {
                            final ship = gameController.playerShips[selectedIndex];
                            final movedShip = ship.copyWith(x: x, y: y);

                            if (gameController.canPlaceShip(movedShip)) {
                              gameController.placeShip(selectedIndex, movedShip);
                            }
                          }
                        },
                      )
                    : const SizedBox.expand(
                        child: Center(child: CircularProgressIndicator()),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Navi disponibili: ${gameController.playerShips.length}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: gameController.playerShips.length,
                      itemBuilder: (context, index) {
                        final ship = gameController.playerShips[index];
                        final isSelected = gameController.selectedShipIndex.value == index;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () {
                              gameController.selectedShipIndex.value = index;
                            },
                            onLongPress: () {
                              gameController.rotateShip(index);
                            },
                            child: Container(
                              width: 50,
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF8B7355),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF6B4226),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${ship.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      gameController.confirmShipPlacement();
                      Get.toNamed('/gameplay');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text('Inizia il Gioco'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
