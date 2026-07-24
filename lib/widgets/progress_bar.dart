import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';

class KeyProgressBar extends StatelessWidget {
  final int collectedKeys;
  final int totalKeys;

  const KeyProgressBar({
    super.key,
    required this.collectedKeys,
    this.totalKeys = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPink.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(totalKeys, (index) {
          final isCollected = index < collectedKeys;
          return _KeySlot(index: index, isCollected: isCollected);
        }),
      ),
    );
  }
}

class _KeySlot extends StatelessWidget {
  final int index;
  final bool isCollected;

  const _KeySlot({required this.index, required this.isCollected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.elasticOut,
          width: 48,
          height: 48,
          decoration: isCollected
              ? BoxDecoration(
                  gradient: AppTheme.goldGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.goldAccent.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                )
              : BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
          child: Center(
            child: Text(
              isCollected ? '🔑' : '🔒',
              style: const TextStyle(fontSize: 22),
            ),
          ),
        )
        .animate(target: isCollected ? 1 : 0)
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.3, 1.3),
          duration: 300.ms,
        )
        .then()
        .scale(
          begin: const Offset(1.3, 1.3),
          end: const Offset(1, 1),
          duration: 300.ms,
        );
  }
}
