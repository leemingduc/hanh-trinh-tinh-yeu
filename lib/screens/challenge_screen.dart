import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../config/challenge_data.dart';
import '../models/challenge.dart';
import '../models/progress.dart';
import '../widgets/progress_bar.dart';
import '../widgets/particles_background.dart';
import '../widgets/animated_button.dart';
import '../games/quiz_game.dart';
import '../games/memory_game.dart';
import '../games/drag_drop_game.dart';
import 'reward_screen.dart';
import '../main.dart';

class ChallengeScreen extends StatefulWidget {
  final int challengeIndex;

  const ChallengeScreen({super.key, required this.challengeIndex});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  bool _showConfetti = false;
  bool _isCompleted = false;

  Challenge get _currentChallenge => challengeData[widget.challengeIndex];

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<Progress>();

    return Scaffold(
      body: ParticlesBackground(
        particleCount: 10,
        child: SafeArea(
          child: Column(
            children: [
              // Top bar with progress
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Column(
                  children: [
                    // Back + Progress
                    Row(
                      children: [
                        if (widget.challengeIndex > 0 ||
                            progress.collectedKeys > 0)
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppTheme.deepPink,
                            ),
                            iconSize: 20,
                          ),
                        Expanded(
                          child: KeyProgressBar(
                            collectedKeys: progress.collectedKeys,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Challenge counter
                    Text(
                      'Thử thách ${widget.challengeIndex + 1} / ${challengeData.length}',
                      style: AppTheme.labelStyle,
                    ),
                  ],
                ),
              ),

              // Challenge content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Challenge header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.deepPink.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentChallenge.icon,
                              style: const TextStyle(fontSize: 28),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentChallenge.title,
                                    style: AppTheme.headlineMedium.copyWith(
                                      color: AppTheme.deepPink,
                                    ),
                                  ),
                                  Text(
                                    _currentChallenge.subtitle,
                                    style: AppTheme.labelStyle.copyWith(
                                      color: AppTheme.textLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 500.ms),

                      const SizedBox(height: 24),

                      // Game content based on challenge type
                      _buildGameContent(),

                      // Continue button after completion
                      if (_isCompleted) ...[
                        const SizedBox(height: 32),
                        AnimatedButton(
                          text: widget.challengeIndex < challengeData.length - 1
                              ? 'Thử thách tiếp theo →'
                              : 'Mở quà! 🎁',
                          icon: widget.challengeIndex < challengeData.length - 1
                              ? Icons.arrow_forward
                              : Icons.card_giftcard,
                          onPressed: () {
                            if (!mounted) return;

                            if (widget.challengeIndex <
                                challengeData.length - 1) {
                              // Chuyển sang thử thách tiếp theo
                              navigatorKey.currentState?.pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => ChallengeScreen(
                                    challengeIndex: widget.challengeIndex + 1,
                                  ),
                                ),
                              );
                            } else {
                              // Hoàn thành thử thách cuối cùng → mở quà
                              navigatorKey.currentState?.pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const RewardScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameContent() {
    switch (_currentChallenge.type) {
      case ChallengeType.quiz:
      case ChallengeType.multiSelect:
      case ChallengeType.special:
        return QuizGame(
          challenge: _currentChallenge,
          onComplete: _onChallengeComplete,
        );
      case ChallengeType.memory:
        return MemoryGame(onComplete: _onChallengeComplete);
      case ChallengeType.dragDrop:
        return DragDropGame(onComplete: _onChallengeComplete);
    }
  }

  void _onChallengeComplete(bool success) {
    if (!success) return;
    final progress = context.read<Progress>();
    progress.completeChallenge(_currentChallenge.id);

    setState(() {
      _showConfetti = true;
      _isCompleted = true;
    });

    // Show confetti effect
    _launchConfetti();
  }

  void _launchConfetti() {
    try {
      // Use flutter_confetti
      Confetti.launch(
        context,
        options: const ConfettiOptions(
          particleCount: 80,
          spread: 70,
          startVelocity: 30,
          scalar: 1.0,
          colors: [
            Color(0xFFFFB6C1),
            Color(0xFFFF69B4),
            Color(0xFFFFD700),
            Color(0xFFFF1744),
            Color(0xFFE91E63),
          ],
        ),
      );
    } catch (e) {
      // Silently handle if confetti fails
      debugPrint('Confetti error: $e');
    }
  }
}
