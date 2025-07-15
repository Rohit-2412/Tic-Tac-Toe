import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<Offset> winningCells;
  final Color color;
  final double progress; // 0.0 to 1.0 for animation

  WinningLinePainter({required this.winningCells, required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (winningCells.length < 2) return;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final start = winningCells.first;
    final end = Offset.lerp(winningCells.first, winningCells.last, progress)!;
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant WinningLinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.winningCells != winningCells;
  }
}
