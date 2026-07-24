import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../config/gift_data.dart';
import '../models/progress.dart';
import '../widgets/particles_background.dart';
import '../widgets/animated_button.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>
    with SingleTickerProviderStateMixin {
  bool _doorOpened = false;
  bool _showGifts = false;
  int _selectedGiftIndex = -1;

  @override
  void initState() {
    super.initState();
    // Sử dụng addPostFrameCallback để đảm bảo context đã sẵn sàng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Progress>().markRewardSeen();
      // Start opening animation after 1 second
      Future.delayed(const Duration(seconds: 1), _startUnlockAnimation);
    });
  }

  void _startUnlockAnimation() {
    setState(() => _doorOpened = true);
    _launchConfetti();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _showGifts = true);
      _launchConfetti();
    });
  }

  void _launchConfetti() {
    try {
      Confetti.launch(
        context,
        options: const ConfettiOptions(
          particleCount: 120,
          spread: 100,
          startVelocity: 35,
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
    } catch (e) {
      debugPrint('Confetti error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParticlesBackground(
        particleCount: 30,
        child: SafeArea(
          child: _showGifts ? _buildGiftsView() : _buildUnlockView(),
        ),
      ),
    );
  }

  Widget _buildUnlockView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Keys flying animation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              return const Text('🔑', style: TextStyle(fontSize: 32))
                  .animate(delay: (i * 200).ms)
                  .slide(
                    duration: 800.ms,
                    begin: Offset((i - 2) * 0.5, 1),
                    end: const Offset(0, 0),
                    curve: Curves.elasticOut,
                  )
                  .then()
                  .rotate(begin: 0, end: 0.1, duration: 300.ms)
                  .then()
                  .rotate(begin: 0.1, end: 0, duration: 300.ms);
            }),
          ),
          const SizedBox(height: 40),

          // Lock/Door
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: _doorOpened
                ? Column(
                    key: const ValueKey('opened'),
                    children: [
                      const Text('🎉', style: TextStyle(fontSize: 80))
                          .animate()
                          .scale(
                            begin: const Offset(0, 0),
                            end: const Offset(1.5, 1.5),
                            duration: 600.ms,
                            curve: Curves.elasticOut,
                          )
                          .then()
                          .scale(
                            begin: const Offset(1.5, 1.5),
                            end: const Offset(1, 1),
                            duration: 400.ms,
                          ),
                      const SizedBox(height: 20),
                      Text(
                        'Chúc mừng bé!',
                        style: AppTheme.displayMedium,
                      ).animate().fadeIn(duration: 600.ms),
                      const SizedBox(height: 12),
                      Text(
                        'Bé đã mở được cánh cửa trái tim!',
                        style: AppTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                    ],
                  )
                : Column(
                    key: const ValueKey('locked'),
                    children: [
                      const Text('🔒', style: TextStyle(fontSize: 80))
                          .animate(onPlay: (c) => c.repeat())
                          .shake(hz: 2, offset: const Offset(4, 0)),
                      const SizedBox(height: 20),
                      Text('Đang mở khóa...', style: AppTheme.headlineMedium),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Text(
            'Quà Tặng Cho Bé',
            style: AppTheme.displayMedium,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 8),
          Text(
            '🎁 Hãy chọn món quà bé muốn xem!',
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.textLight),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 32),

          // Gift cards
          ...List.generate(allGifts.length, (index) {
            final gift = allGifts[index];
            final isSelected = _selectedGiftIndex == index;

            return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedGiftIndex = isSelected ? -1 : index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppTheme.buttonGradient : null,
                        color: isSelected ? null : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                (isSelected
                                        ? AppTheme.deepPink
                                        : AppTheme.primaryPink)
                                    .withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                gift.icon,
                                style: const TextStyle(fontSize: 36),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      gift.title,
                                      style: AppTheme.headlineMedium.copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : AppTheme.textDark,
                                      ),
                                    ),
                                    Text(
                                      gift.description,
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: isSelected
                                            ? Colors.white.withOpacity(0.8)
                                            : AppTheme.textLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isSelected
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.textLight,
                              ),
                            ],
                          ),

                          // Expanded content
                          if (isSelected && gift.content != null) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                gift.content!,
                                style: AppTheme.bodyMedium.copyWith(
                                  height: 1.8,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ).animate().fadeIn(duration: 400.ms),
                          ],

                          // Voucher usage
                          if (isSelected && gift.content == null) ...[
                            const SizedBox(height: 16),
                            _VoucherCard(gift: gift),
                          ],
                        ],
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: (300 + index * 150).ms, duration: 500.ms)
                .slideY(begin: 0.2, end: 0);
          }),

          const SizedBox(height: 32),

          // Final message
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.deepPink.withOpacity(0.1),
                  AppTheme.primaryPink.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.primaryPink, width: 2),
            ),
            child: Column(
              children: [
                const Text('💕', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text(
                  'Anh yêu bé nhiều lắm!',
                  style: AppTheme.displayMedium.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cảm ơn bé đã là một phần tuyệt vời trong cuộc đời anh.\n'
                  'Chúc mừng kỷ niệm 1 tháng của chúng mình! 🎉',
                  style: AppTheme.bodyMedium.copyWith(
                    height: 1.6,
                    color: AppTheme.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 800.ms, duration: 800.ms),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _VoucherCard extends StatefulWidget {
  final dynamic gift;
  const _VoucherCard({required this.gift});

  @override
  State<_VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<_VoucherCard> {
  bool _isUsed = false;

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<Progress>();
    final isUsed = progress.isVoucherUsed(widget.gift.id);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUsed ? Colors.grey.shade300 : AppTheme.goldAccent,
          width: 2,
          style: isUsed ? BorderStyle.solid : BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.gift.icon, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.gift.title,
                      style: AppTheme.headlineMedium.copyWith(
                        color: isUsed ? Colors.grey : AppTheme.textDark,
                        decoration: isUsed ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(widget.gift.description, style: AppTheme.labelStyle),
                  ],
                ),
              ),
              if (isUsed)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Đã dùng',
                    style: AppTheme.labelStyle.copyWith(color: Colors.grey),
                  ),
                ),
            ],
          ),
          if (!isUsed) ...[
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                progress.useVoucher(widget.gift.id);
                Confetti.launch(
                  context,
                  options: const ConfettiOptions(
                    particleCount: 40,
                    spread: 60,
                    startVelocity: 20,
                    scalar: 0.8,
                    colors: [Color(0xFFFFB6C1), Color(0xFFFFD700)],
                  ),
                );
                setState(() => _isUsed = true);
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Sử dụng phiếu'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.successGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
