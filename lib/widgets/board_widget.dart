import 'package:flutter/material.dart';
import 'package:battaglia_navale/models/board.dart';

class BoardPainter extends CustomPainter {
  final Board board;
  final bool isOpponentBoard;
  final Function(int, int)? onCellTapped;
  final Color backgroundColor;
  final Color gridColor;

  BoardPainter({
    required this.board,
    this.isOpponentBoard = false,
    this.onCellTapped,
    this.backgroundColor = const Color(0xFFFBF5ED),
    this.gridColor = const Color(0xFF8B7355),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / board.width;
    final cellHeight = size.height / board.height;

    // Sfondo carta
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Griglia
    final gridPaint = Paint()
      ..color = gridColor
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

    // Disegna le celle
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
        final cell = board.getCell(x, y);
        final rect = Rect.fromLTWH(
          x * cellWidth + 1,
          y * cellHeight + 1,
          cellWidth - 2,
          cellHeight - 2,
        );

        _drawCell(canvas, rect, cell, cellWidth, cellHeight);
      }
    }
  }

  void _drawCell(Canvas canvas, Rect rect, Cell cell, double cellWidth, double cellHeight) {
    final paint = Paint()..style = PaintingStyle.fill;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    if (!cell.isRevealed && !isOpponentBoard && cell.shipId != null) {
      // Mostra la nave sulla griglia del giocatore
      paint.color = const Color(0xFF6B4226).withAlpha(200);
      canvas.drawRect(rect, paint);
    } else if (cell.isRevealed) {
      if (cell.state == CellState.hit) {
        // Colpito - X rossa
        paint.color = const Color(0xFFD32F2F);
        canvas.drawRect(rect, paint);
        _drawX(canvas, rect.center, 15, const Color(0xFF8B0000));
      } else if (cell.state == CellState.miss) {
        // Acqua - punto blu leggero
        paint.color = const Color(0xFF90CAF9).withAlpha(100);
        canvas.drawRect(rect, paint);
        canvas.drawCircle(rect.center, 3, Paint()..color = const Color(0xFF0D47A1));
      } else if (cell.state == CellState.sunk) {
        // Affondato - griglia diagonale
        paint.color = const Color(0xFF1A237E);
        canvas.drawRect(rect, paint);
      }
    }
  }

  void _drawX(Canvas canvas, Offset center, double size, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final offset = size / 2;
    canvas.drawLine(
      Offset(center.dx - offset, center.dy - offset),
      Offset(center.dx + offset, center.dy + offset),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + offset, center.dy - offset),
      Offset(center.dx - offset, center.dy + offset),
      paint,
    );
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) {
    return oldDelegate.board != board || oldDelegate.isOpponentBoard != isOpponentBoard;
  }
}

class BoardWidget extends StatelessWidget {
  final Board board;
  final bool isOpponentBoard;
  final Function(int, int)? onCellTapped;

  const BoardWidget({
    Key? key,
    required this.board,
    this.isOpponentBoard = false,
    this.onCellTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        if (onCellTapped != null) {
          final x = (details.localPosition.dx / (context.size?.width ?? 1) * board.width).toInt();
          final y = (details.localPosition.dy / (context.size?.height ?? 1) * board.height).toInt();

          if (x >= 0 && x < board.width && y >= 0 && y < board.height) {
            onCellTapped!(x, y);
          }
        }
      },
      child: CustomPaint(
        painter: BoardPainter(
          board: board,
          isOpponentBoard: isOpponentBoard,
          onCellTapped: onCellTapped,
        ),
        child: Container(),
      ),
    );
  }
}
