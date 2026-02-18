import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:battaglia_navale/controllers/game_controller.dart';
import 'package:battaglia_navale/models/game_config.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  late GameController gameController;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    gameController = Get.put(GameController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5ED),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Battaglia Navale',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontFamily: 'PaperBoy',
                            fontSize: 48,
                            color: const Color(0xFF6B4226),
                          ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: isScanning
                          ? null
                          : () {
                              setState(() => isScanning = true);
                              gameController.startScanning();
                              Future.delayed(const Duration(seconds: 15), () {
                                if (mounted) {
                                  setState(() => isScanning = false);
                                  gameController.stopScanning();
                                }
                              });
                            },
                      icon: const Icon(Icons.bluetooth),
                      label: Text(
                        isScanning ? 'Ricerca in corso...' : 'Cerca Avversario',
                        style: const TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        backgroundColor: const Color(0xFF8B7355),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (isScanning)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B4226)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  final config = GameConfig.getClassicPreset();
                  gameController.initializeGame(config);
                  Get.toNamed('/setup');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                ),
                child: const Text('Gioca Offline (Test)'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    gameController.stopScanning();
    super.dispose();
  }
}
