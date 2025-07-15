import 'package:flutter/material.dart';

class CircularTimer extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final int secondsLeft;
  final Color color;

  const CircularTimer({required this.progress, required this.secondsLeft, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 6,
            color: color,
            backgroundColor: color.withOpacity(0.2),
          ),
        ),
        Text(
          '$secondsLeft',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
