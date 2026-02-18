// Utility per le coordinate della griglia
class GridUtils {
  static bool isValidCoordinate(int x, int y, int width, int height) {
    return x >= 0 && x < width && y >= 0 && y < height;
  }

  static List<(int, int)> getAdjacentCells(int x, int y, int width, int height) {
    List<(int, int)> adjacentCells = [];
    
    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;
        final adjX = x + dx;
        final adjY = y + dy;
        
        if (isValidCoordinate(adjX, adjY, width, height)) {
          adjacentCells.add((adjX, adjY));
        }
      }
    }
    
    return adjacentCells;
  }

  static bool areShipsAdjacent(
    List<(int, int)> cellsA,
    List<(int, int)> cellsB,
    int width,
    int height,
  ) {
    for (var cellA in cellsA) {
      final adjacent = getAdjacentCells(cellA.$1, cellA.$2, width, height);
      for (var adj in adjacent) {
        if (cellsB.contains(adj)) {
          return true;
        }
      }
    }
    return false;
  }
}

// Utility per i colori
class GameColors {
  static const Color paperBg = Color(0xFFFBF5ED);
  static const Color darkBrown = Color(0xFF6B4226);
  static const Color brownt = Color(0xFF8B7355);
  static const Color lightBrown = Color(0xFFB8956A);
  static const Color green = Color(0xFF4CAF50);
  static const Color red = Color(0xFFF44336);
  static const Color blue = Color(0xFF2196F3);
  static const Color hitColor = Color(0xFFD32F2F);
  static const Color missColor = Color(0xFF90CAF9);
  static const Color sunkColor = Color(0xFF1A237E);
}

import 'package:flutter/material.dart';
