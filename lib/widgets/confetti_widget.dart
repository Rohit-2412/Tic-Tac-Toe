import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CelebrationConfetti extends StatelessWidget {
  final ConfettiController controller;
  const CelebrationConfetti({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: controller,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      colors: const [
        Colors.red,
        Colors.blue,
        Colors.orange,
        Colors.green
      ],
      numberOfParticles: 30,
      maxBlastForce: 20,
      minBlastForce: 5,
      gravity: 0.3,
    );
  }
}
