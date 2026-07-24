import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/challenge_data.dart';
import '../models/challenge.dart';

class MemoryGame extends StatefulWidget {
  final Function(bool success) onComplete;

  const MemoryGame({super.key, required this.onComplete});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  late List<MemoryCard> _cards;
  int? _firstFlippedIndex;
  bool _isChecking = false;
  int _matchedPairs = 0;
  int _moves = 0;
  final int _totalPairs = 4;

  @override
  void initState() {
    super.initState();
    _initCards();
  }

  void _initCards() {
    _cards = memoryCardsData.map((c) => c.copyWith()).toList()
      ..shuffle(Random());
    _matchedPairs = 0;
    _moves = 0;
    _firstFlippedIndex = null;
    _isChecking = false;
  }

  void _onCardTap(int index) {
    if (_isChecking) return;
    if (_cards[index].isFlipped || _cards[index].isMatched) return;
    if (index == _firstFlippedIndex) return;

    setState(() {
      _cards[index] = _cards[index].copyWith(isFlipped: true);
    });

    if (_firstFlippedIndex == null) {
      _firstFlippedIndex = index;
    } else {
      _isChecking = true;
      _moves++;

      final firstCard = _cards[_firstFlippedIndex!];
      final secondCard = _cards[index];

      if (firstCard.pairId == secondCard.pairId) {
        // Match!
        setState(() {
          _cards[_firstFlippedIndex!] = firstCard.copyWith(isMatched: true);
          _cards[index] = secondCard.copyWith(isMatched: true);
          _matchedPairs++;
        });
        _firstFlippedIndex = null;
        _isChecking = false;

        if (_matchedPairs == _totalPairs) {
          Future.delayed(const Duration(seconds: 1), () {
            widget.onComplete(true);
          });
        }
      } else {
        // No match
        Future.delayed(const Duration(milliseconds: 800), () {
          setState(() {
            _cards[_firstFlippedIndex!] = firstCard.copyWith(isFlipped: false);
            _cards[index] = secondCard.copyWith(isFlipped: false);
            _firstFlippedIndex = null;
            _isChecking = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Stats
        Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatChip(icon: '🎯', label: 'Số bước', value: '$_moves'),
              _StatChip(
                icon: '💕',
                label: 'Cặp tìm được',
                value: '$_matchedPairs/$_totalPairs',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Card grid - 4x2 for mobile
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: _cards.length,
          itemBuilder: (context, index) {
            final card = _cards[index];
            final showFront = card.isFlipped || card.isMatched;

            return GestureDetector(
              onTap: () => _onCardTap(index),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Container(
                  key: ValueKey('${card.id}_$showFront'),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: showFront ? null : AppTheme.buttonGradient,
                    color: showFront
                        ? (card.isMatched
                              ? AppTheme.successGreen.withOpacity(0.1)
                              : Colors.white)
                        : null,
                    border: Border.all(
                      color: card.isMatched
                          ? AppTheme.successGreen
                          : (showFront
                                ? AppTheme.deepPink
                                : Colors.transparent),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (showFront
                                    ? AppTheme.deepPink
                                    : AppTheme.primaryPink)
                                .withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: showFront
                        ? Text(
                            card.emoji,
                            style: const TextStyle(fontSize: 40),
                          ).animate().scale(
                            begin: const Offset(0.5, 0.5),
                            end: const Offset(1, 1),
                            duration: 300.ms,
                            curve: Curves.elasticOut,
                          )
                        : const Text('❓', style: TextStyle(fontSize: 36)),
                  ),
                ),
              ),
            );
          },
        ),

        // Hint after many moves
        if (_moves > 8 && _matchedPairs < _totalPairs) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.lightPink,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Text('💡', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Cố lên bé! Hãy nhớ vị trí của từng thẻ nhé 🧠💖',
                    style: AppTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(),
        ],

        // Reset button
        const SizedBox(height: 16),
        Center(
          child: TextButton.icon(
            onPressed: () {
              setState(() => _initCards());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Xáo trộn lại'),
            style: TextButton.styleFrom(foregroundColor: AppTheme.deepPink),
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(label, style: AppTheme.labelStyle),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTheme.headlineMedium.copyWith(color: AppTheme.deepPink),
        ),
      ],
    );
  }
}
