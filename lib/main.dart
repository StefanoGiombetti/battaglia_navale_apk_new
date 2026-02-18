import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:battaglia_navale/screens/lobby_screen.dart';
import 'package:battaglia_navale/screens/setup_screen.dart';
import 'package:battaglia_navale/screens/ship_placement_screen.dart';
import 'package:battaglia_navale/screens/gameplay_screen.dart';

void main() {
  runApp(const BattagliaNavaleApp());
}

class BattagliaNavaleApp extends StatelessWidget {
  const BattagliaNavaleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Battaglia Navale',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B7355),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Segoe UI',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6B4226),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B4226),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B7355),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const LobbyScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/setup',
          page: () => const SetupScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/shipplacement',
          page: () => const ShipPlacementScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/gameplay',
          page: () => const GameplayScreen(),
          transition: Transition.fadeIn,
        ),
      ],
      initialRoute: '/',
      home: const LobbyScreen(),
    );
  }
}
