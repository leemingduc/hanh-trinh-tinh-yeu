import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../widgets/particles_background.dart';
import '../widgets/animated_button.dart';

class ChallengeListScreen extends StatelessWidget {
  final VoidCallback onSelectChallenge;

  const ChallengeListScreen({super.key, required this.onSelectChallenge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParticlesBackground(
        particleCount: 10,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Hành Trình Tình Yêu',
                  style: AppTheme.displayMedium.copyWith(fontSize: 32),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(),
                const SizedBox(height: 32),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('💕', style: TextStyle(fontSize: 60))
                            .animate()
                            .scale(
                              begin: const Offset(0.8, 0.8),
                              end: const Offset(1.1, 1.1),
                              duration: 1200.ms,
                              curve: Curves.easeInOut,
                            )
                            .then()
                            .scale(
                              begin: const Offset(1.1, 1.1),
                              end: const Offset(0.8, 0.8),
                              duration: 1200.ms,
                              curve: Curves.easeInOut,
                            ),
                        const SizedBox(height: 24),
                        Text(
                          'Bé đã sẵn sàng chưa?',
                          style: AppTheme.headlineLarge,
                        ).animate().fadeIn(delay: 300.ms),
                        const SizedBox(height: 12),
                        Text(
                          '5 thử thách tình yêu đang chờ bé!',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textLight,
                          ),
                        ).animate().fadeIn(delay: 500.ms),
                        const SizedBox(height: 40),
                        AnimatedButton(
                          text: 'Bắt Đầu Ngay! 💖',
                          icon: Icons.play_arrow,
                          onPressed: onSelectChallenge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
