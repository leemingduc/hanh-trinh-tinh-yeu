import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Progress extends ChangeNotifier {
  static const String _keysKey = 'love_journey_keys';
  static const String _completedChallengesKey = 'love_journey_completed';
  static const String _usedVouchersKey = 'love_journey_vouchers';
  static const String _hasSeenRewardKey = 'love_journey_reward_seen';

  int _collectedKeys = 0;
  final Set<String> _completedChallenges = {};
  final Set<String> _usedVouchers = {};
  bool _hasSeenReward = false;

  int get collectedKeys => _collectedKeys;
  bool get isComplete => _collectedKeys >= 5;
  bool get hasSeenReward => _hasSeenReward;
  Set<String> get completedChallenges => _completedChallenges;
  Set<String> get usedVouchers => _usedVouchers;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _collectedKeys = prefs.getInt(_keysKey) ?? 0;
    _hasSeenReward = prefs.getBool(_hasSeenRewardKey) ?? false;

    final completed = prefs.getStringList(_completedChallengesKey) ?? [];
    _completedChallenges.addAll(completed);

    final vouchers = prefs.getStringList(_usedVouchersKey) ?? [];
    _usedVouchers.addAll(vouchers);

    notifyListeners();
  }

  Future<void> completeChallenge(String challengeId) async {
    if (_completedChallenges.contains(challengeId)) return;

    _completedChallenges.add(challengeId);
    _collectedKeys++;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keysKey, _collectedKeys);
    await prefs.setStringList(
      _completedChallengesKey,
      _completedChallenges.toList(),
    );

    notifyListeners();
  }

  Future<void> useVoucher(String voucherId) async {
    if (_usedVouchers.contains(voucherId)) return;

    _usedVouchers.add(voucherId);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_usedVouchersKey, _usedVouchers.toList());

    notifyListeners();
  }

  Future<void> markRewardSeen() async {
    _hasSeenReward = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenRewardKey, true);
    notifyListeners();
  }

  Future<void> reset() async {
    _collectedKeys = 0;
    _completedChallenges.clear();
    _usedVouchers.clear();
    _hasSeenReward = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keysKey);
    await prefs.remove(_completedChallengesKey);
    await prefs.remove(_usedVouchersKey);
    await prefs.remove(_hasSeenRewardKey);

    notifyListeners();
  }

  bool isChallengeCompleted(String challengeId) {
    return _completedChallenges.contains(challengeId);
  }

  bool isVoucherUsed(String voucherId) {
    return _usedVouchers.contains(voucherId);
  }
}
