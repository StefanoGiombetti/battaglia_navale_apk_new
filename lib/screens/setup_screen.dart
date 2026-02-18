import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:battaglia_navale/controllers/game_controller.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameController = Get.find<GameController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFBF5ED),
      appBar: AppBar(
        title: const Text('Configurazione'),
        backgroundColor: const Color(0xFF8B7355),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Obx(
          () => gameController.gameConfig.value != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Griglia: ${gameController.gameConfig.value!.gridWidth}x${gameController.gameConfig.value!.gridHeight}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Navi: ${gameController.gameConfig.value!.shipLengths.join(', ')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/shipplacement');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: const Text('Continua'),
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
