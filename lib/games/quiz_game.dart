import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../models/challenge.dart';
import '../widgets/animated_button.dart';

class QuizGame extends StatefulWidget {
  final Challenge challenge;
  final Function(bool success) onComplete;

  const QuizGame({
    super.key,
    required this.challenge,
    required this.onComplete,
  });

  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  final Set<int> _selectedAnswers = {};
  bool _hasAnswered = false;
  bool _isCorrect = false;
  int _attempts = 0;

  @override
  Widget build(BuildContext context) {
    final isMulti =
        widget.challenge.type == ChallengeType.multiSelect ||
        widget.challenge.correctAnswers.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Question
        Container(
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.cardDecoration,
          child: Column(
            children: [
              Text(
                widget.challenge.icon,
                style: const TextStyle(fontSize: 48),
              ).animate().scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.elasticOut,
              ),
              const SizedBox(height: 16),
              Text(
                widget.challenge.question,
                style: AppTheme.headlineMedium,
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Options
        ...List.generate(widget.challenge.options.length, (index) {
          final isSelected = _selectedAnswers.contains(index);
          final isCorrectAnswer = widget.challenge.correctAnswers.contains(
            index,
          );
          final showResult = _hasAnswered;

          Color borderColor;
          Color bgColor;
          if (showResult && isSelected && isCorrectAnswer) {
            borderColor = AppTheme.successGreen;
            bgColor = AppTheme.successGreen.withOpacity(0.1);
          } else if (showResult && isSelected && !isCorrectAnswer) {
            borderColor = AppTheme.errorRed;
            bgColor = AppTheme.errorRed.withOpacity(0.1);
          } else if (showResult && isCorrectAnswer) {
            borderColor = AppTheme.successGreen;
            bgColor = AppTheme.successGreen.withOpacity(0.05);
          } else if (isSelected) {
            borderColor = AppTheme.deepPink;
            bgColor = AppTheme.deepPink.withOpacity(0.1);
          } else {
            borderColor = Colors.grey.shade300;
            bgColor = Colors.white;
          }

          return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: _hasAnswered
                      ? null
                      : () {
                          if (isMulti) {
                            setState(() {
                              if (isSelected) {
                                _selectedAnswers.remove(index);
                              } else {
                                _selectedAnswers.add(index);
                              }
                            });
                          } else {
                            // Single select: chọn đáp án
                            _selectedAnswers.clear();
                            _selectedAnswers.add(index);
                            // Tự động kiểm tra sau 300ms
                            Future.delayed(
                              const Duration(milliseconds: 300),
                              () {
                                if (mounted) _doCheck();
                              },
                            );
                            setState(
                              () {},
                            ); // Refresh UI để show đáp án được chọn
                          }
                        },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor, width: 2),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: borderColor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.deepPink
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                            color: isSelected
                                ? AppTheme.deepPink
                                : Colors.transparent,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            widget.challenge.options[index],
                            style: AppTheme.bodyLarge.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: (400 + index * 100).ms, duration: 400.ms)
              .slideX(begin: 0.1, end: 0);
        }),

        const SizedBox(height: 16),

        // Submit button for multi-select
        if (isMulti && !_hasAnswered) _buildSubmitButton(),

        // Hint if wrong
        if (_hasAnswered && !_isCorrect) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.lightPink,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.primaryPink, width: 1),
            ),
            child: Row(
              children: [
                const Text('💡', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.challenge.hint,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.2),
        ],

        // Success message
        if (_hasAnswered && _isCorrect) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.successGreen, width: 1),
            ),
            child: Row(
              children: [
                const Text('🎉', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.challenge.successMessage,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.successGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
            curve: Curves.elasticOut,
          ),
        ],

        // Retry button if wrong
        if (_hasAnswered && !_isCorrect) ...[
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: _retry,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryPink,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSubmitButton() {
    return AnimatedButton(
      text: 'Xác nhận',
      icon: Icons.check_circle,
      onPressed: _selectedAnswers.isEmpty ? () {} : _checkAnswer,
    );
  }

  void _checkAnswer() {
    if (_selectedAnswers.isEmpty) return;

    final isMulti = widget.challenge.correctAnswers.length > 1;

    // For single select, check immediately on tap
    if (!isMulti && _selectedAnswers.length == 1) {
      _doCheck();
      return;
    }

    _doCheck();
  }

  void _doCheck() {
    setState(() {
      _hasAnswered = true;
      _attempts++;
      _isCorrect = widget.challenge.isAnswerCorrect(_selectedAnswers.toList());
    });

    if (_isCorrect) {
      Future.delayed(const Duration(seconds: 2), () {
        widget.onComplete(true);
      });
    }
  }

  void _retry() {
    setState(() {
      _selectedAnswers.clear();
      _hasAnswered = false;
      _isCorrect = false;
    });
  }
}
