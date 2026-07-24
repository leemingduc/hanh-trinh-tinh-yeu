import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/challenge_data.dart';
import '../models/challenge.dart';

class DragDropGame extends StatefulWidget {
  final Function(bool success) onComplete;

  const DragDropGame({super.key, required this.onComplete});

  @override
  State<DragDropGame> createState() => _DragDropGameState();
}

class _DragDropGameState extends State<DragDropGame> {
  late List<TimelineEvent> _events;
  bool _isChecked = false;
  bool _isCorrect = false;
  int _attempts = 0;

  @override
  void initState() {
    super.initState();
    _events = List.from(timelineEventsData);
    _events.shuffle();
  }

  void _moveUp(int index) {
    if (index == 0) return;
    setState(() {
      final temp = _events[index];
      _events[index] = _events[index - 1];
      _events[index - 1] = temp;
    });
  }

  void _moveDown(int index) {
    if (index == _events.length - 1) return;
    setState(() {
      final temp = _events[index];
      _events[index] = _events[index + 1];
      _events[index + 1] = temp;
    });
  }

  void _checkOrder() {
    bool correct = true;
    for (int i = 0; i < _events.length; i++) {
      if (_events[i].correctOrder != i + 1) {
        correct = false;
        break;
      }
    }

    setState(() {
      _isChecked = true;
      _isCorrect = correct;
      _attempts++;
    });

    if (correct) {
      Future.delayed(const Duration(seconds: 2), () {
        widget.onComplete(true);
      });
    }
  }

  void _retry() {
    setState(() {
      _isChecked = false;
      _isCorrect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.cardDecoration,
          child: Column(
            children: [
              const Text('📅', style: TextStyle(fontSize: 48)).animate().scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                curve: Curves.elasticOut,
                duration: 500.ms,
              ),
              const SizedBox(height: 12),
              Text(
                'Sắp xếp các sự kiện theo đúng thứ tự thời gian!',
                style: AppTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Event list with reorder arrows
        ...List.generate(_events.length, (index) {
          final event = _events[index];
          final isCorrectPosition =
              _isChecked && event.correctOrder == index + 1;
          final isWrongPosition = _isChecked && event.correctOrder != index + 1;

          return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: isCorrectPosition
                        ? AppTheme.successGreen.withOpacity(0.1)
                        : (isWrongPosition
                              ? AppTheme.errorRed.withOpacity(0.1)
                              : Colors.white),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCorrectPosition
                          ? AppTheme.successGreen
                          : (isWrongPosition
                                ? AppTheme.errorRed
                                : AppTheme.primaryPink.withOpacity(0.3)),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryPink.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Order number
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            gradient: AppTheme.goldGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: AppTheme.headlineMedium.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Event info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    event.icon,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      event.title,
                                      style: AppTheme.bodyLarge.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(event.date, style: AppTheme.labelStyle),
                            ],
                          ),
                        ),

                        // Reorder buttons
                        if (!_isChecked) ...[
                          _ArrowButton(
                            icon: Icons.keyboard_arrow_up,
                            onTap: index > 0 ? () => _moveUp(index) : null,
                          ),
                          const SizedBox(width: 4),
                          _ArrowButton(
                            icon: Icons.keyboard_arrow_down,
                            onTap: index < _events.length - 1
                                ? () => _moveDown(index)
                                : null,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: (index * 100).ms, duration: 400.ms)
              .slideX(begin: 0.1, end: 0);
        }),

        const SizedBox(height: 16),

        // Check button
        if (!_isChecked)
          ElevatedButton.icon(
            onPressed: _checkOrder,
            icon: const Icon(Icons.check_circle),
            label: const Text('Kiểm tra'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.deepPink,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

        // Result
        if (_isChecked) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (_isCorrect ? AppTheme.successGreen : AppTheme.errorRed)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isCorrect ? AppTheme.successGreen : AppTheme.errorRed,
              ),
            ),
            child: Row(
              children: [
                Text(
                  _isCorrect ? '🎉' : '💡',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _isCorrect
                        ? 'Hoàn hảo! Hành trình của chúng mình thật đẹp 🌈'
                        : 'Chưa đúng rồi bé, thử sắp xếp lại nhé!',
                    style: AppTheme.bodyMedium.copyWith(
                      color: _isCorrect
                          ? AppTheme.successGreen
                          : AppTheme.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(),
        ],

        if (_isChecked && !_isCorrect) ...[
          const SizedBox(height: 12),
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
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: onTap != null
              ? AppTheme.primaryPink.withOpacity(0.2)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: onTap != null ? AppTheme.deepPink : Colors.grey.shade400,
          size: 20,
        ),
      ),
    );
  }
}
