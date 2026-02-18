import 'package:flutter/material.dart';
import 'package:battaglia_navale/models/board.dart';
import 'package:battaglia_navale/models/ship.dart';

class ShipPlacementPainter extends CustomPainter {
  final Board board;
  final Ship? selectedShip;
  final bool isValidPlacement;

  ShipPlacementPainter({
    required this.board,
    this.selectedShip,
    this.isValidPlacement = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / board.width;
    final cellHeight = size.height / board.height;

    // Sfondo carta
    final backgroundPaint = Paint()
      ..color = const Color(0xFFFBF5ED)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Griglia
    final gridPaint = Paint()
      ..color = const Color(0xFF8B7355)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int x = 0; x <= board.width; x++) {
      final dx = x * cellWidth;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), gridPaint);
    }

    for (int y = 0; y <= board.height; y++) {
      final dy = y * cellHeight;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), gridPaint);
    }

    // Disegna le navi
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
        final cell = board.getCell(x, y);
        if (cell.shipId != null) {
          final rect = Rect.fromLTWH(
            x * cellWidth + 1,
            y * cellHeight + 1,
            cellWidth - 2,
            cellHeight - 2,
          );

          final shipPaint = Paint()
            ..color = const Color(0xFF6B4226)
            ..style = PaintingStyle.fill;
          canvas.drawRect(rect, shipPaint);
        }
      }
    }

    // Disegna la nave selezionata (anteprima)
    if (selectedShip != null) {
      final previewColor = isValidPlacement
          ? const Color(0xFF4CAF50).withAlpha(150)
          : const Color(0xFFF44336).withAlpha(150);

      _drawShip(
        canvas,
        selectedShip!,
        cellWidth,
        cellHeight,
        previewColor,
      );
    }
  }

  void _drawShip(Canvas canvas, Ship ship, double cellWidth, double cellHeight, Color color) {
    final cells = ship.getCells();
    
    for (var (x, y) in cells) {
      if (x >= 0 && x < board.width && y >= 0 && y < board.height) {
        final rect = Rect.fromLTWH(
          x * cellWidth + 1,
          y * cellHeight + 1,
          cellWidth - 2,
          cellHeight - 2,
        );

        final paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(ShipPlacementPainter oldDelegate) {
    return oldDelegate.board != board || 
        oldDelegate.selectedShip != selectedShip ||
        oldDelegate.isValidPlacement != isValidPlacement;
  }
}

class ShipPlacementWidget extends StatelessWidget {
  final Board board;
  final Ship? selectedShip;
  final bool isValidPlacement;
  final Function(int, int)? onTapMove;

  const ShipPlacementWidget({
    Key? key,
    required this.board,
    this.selectedShip,
    this.isValidPlacement = false,
    this.onTapMove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        if (onTapMove != null) {
          final x = (details.localPosition.dx / (context.size?.width ?? 1) * board.width).toInt();
          final y = (details.localPosition.dy / (context.size?.height ?? 1) * board.height).toInt();

          if (x >= 0 && x < board.width && y >= 0 && y < board.height) {
            onTapMove!(x, y);
          }
        }
      },
      child: CustomPaint(
        painter: ShipPlacementPainter(
          board: board,
          selectedShip: selectedShip,
          isValidPlacement: isValidPlacement,
        ),
        child: Container(),
      ),
    );
  }
}
