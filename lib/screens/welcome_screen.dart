import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../widgets/particles_background.dart';
import '../widgets/animated_button.dart';
import '../models/progress.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStart;

  const WelcomeScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ParticlesBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated heart
                  const Text('💕', style: TextStyle(fontSize: 80))
                      .animate(onPlay: (c) => c.repeat())
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.15, 1.15),
                        duration: 1200.ms,
                        curve: Curves.easeInOut,
                      ),

                  const SizedBox(height: 24),

                  // Title
                  Text(
                    'Hành Trình',
                    style: AppTheme.displayLarge.copyWith(
                      fontSize: screenWidth < 400 ? 40 : 52,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
                  Text(
                    'Tình Yêu',
                    style: AppTheme.displayLarge.copyWith(
                      fontSize: screenWidth < 400 ? 40 : 52,
                      color: AppTheme.roseRed,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 800.ms, delay: 400.ms),

                  const SizedBox(height: 16),

                  // Subtitle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Kỷ niệm 1 tháng yêu nhau',
                      style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.deepPink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 700.ms),

                  const SizedBox(height: 8),

                  Text(
                    '30/6/2026 → 30/7/2026',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textLight,
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 900.ms),

                  const SizedBox(height: 40),

                  // Description card
                  Container(
                        padding: const EdgeInsets.all(24),
                        decoration: AppTheme.cardDecoration,
                        child: Column(
                          children: [
                            Text(
                              'Gửi bé yêu của anh',
                              style: AppTheme.headlineMedium.copyWith(
                                color: AppTheme.deepPink,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Anh đã chuẩn bị một hành trình đặc biệt dành cho bé.\n\n'
                              'Hãy vượt qua 5 thử thách tình yêu để thu thập 5 chiếc chìa khóa vàng 🔑\n\n'
                              'Khi đủ 5 chìa khóa, một món quà bất ngờ sẽ chờ bé! 🎁',
                              style: AppTheme.bodyMedium.copyWith(height: 1.6),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 1100.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 40),

                  // Start button
                  AnimatedButton(
                    text: 'Bắt Đầu Hành Trình 💖',
                    icon: Icons.favorite,
                    onPressed: onStart,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
