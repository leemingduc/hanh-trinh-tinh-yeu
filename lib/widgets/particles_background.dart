import 'dart:math';
import 'package:flutter/material.dart';

class ParticlesBackground extends StatefulWidget {
  final Widget child;
  final int particleCount;
  const ParticlesBackground({
    super.key,
    required this.child,
    this.particleCount = 20,
  });

  @override
  State<ParticlesBackground> createState() => _ParticlesBackgroundState();
}

class _ParticlesBackgroundState extends State<ParticlesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _particles = List.generate(widget.particleCount, (i) => _Particle.random());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              size: Size.infinite,
              painter: _ParticlePainter(
                particles: _particles,
                animation: _controller.value,
              ),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _Particle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;
  String emoji;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.emoji,
  });

  factory _Particle.random() {
    final emojis = ['💕', '💖', '💗', '🌸', '✨', '💫'];
    return _Particle(
      x: Random().nextDouble(),
      y: Random().nextDouble(),
      size: Random().nextDouble() * 20 + 14,
      speed: Random().nextDouble() * 0.5 + 0.2,
      opacity: Random().nextDouble() * 0.5 + 0.3,
      emoji: emojis[Random().nextInt(emojis.length)],
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double animation;

  _ParticlePainter({required this.particles, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: p.emoji,
          style: TextStyle(fontSize: p.size),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final yOffset =
          (p.y * size.height - animation * p.speed * size.height) % size.height;
      final xOffset = p.x * size.width + sin(animation * 2 * pi * p.speed) * 20;

      canvas.save();
      canvas.translate(xOffset, yOffset < 0 ? yOffset + size.height : yOffset);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
