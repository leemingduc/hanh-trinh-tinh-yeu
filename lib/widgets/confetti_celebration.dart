import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

class ConfettiCelebration extends StatefulWidget {
  final Widget child;
  final bool shouldFire;

  const ConfettiCelebration({
    super.key,
    required this.child,
    this.shouldFire = false,
  });

  @override
  State<ConfettiCelebration> createState() => _ConfettiCelebrationState();
}

class _ConfettiCelebrationState extends State<ConfettiCelebration> {
  ConfettiController? _controller;

  @override
  void didUpdateWidget(covariant ConfettiCelebration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldFire && !oldWidget.shouldFire) {
      _fireConfetti();
    }
  }

  void _fireConfetti() {
    _controller = Confetti.launch(
      context,
      options: const ConfettiOptions(
        particleCount: 100,
        spread: 70,
        startVelocity: 30,
        scalar: 1.2,
        colors: [
          Color(0xFFFFB6C1),
          Color(0xFFFF69B4),
          Color(0xFFFFD700),
          Color(0xFFFF1744),
          Color(0xFFE91E63),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
