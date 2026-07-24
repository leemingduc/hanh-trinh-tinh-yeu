import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'models/progress.dart';
import 'screens/welcome_screen.dart';
import 'screens/challenge_screen.dart';
import 'screens/reward_screen.dart';

void main() {
  runApp(const LoveJourneyApp());
}

// Global navigator key để navigation không phụ thuộc widget context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoveJourneyApp extends StatelessWidget {
  const LoveJourneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Progress()..load(),
      child: MaterialApp(
        title: 'Hành Trình Tình Yêu',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        navigatorKey: navigatorKey,
        home: const AppHome(),
      ),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<Progress>();

    // If all challenges completed, show reward
    if (progress.isComplete) {
      return const RewardScreen();
    }

    // If some challenges completed, continue from last
    if (progress.collectedKeys > 0 && progress.collectedKeys < 5) {
      return ChallengeScreen(challengeIndex: progress.collectedKeys);
    }

    // Show welcome screen
    return WelcomeScreen(
      onStart: () {
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (_) => const ChallengeScreen(challengeIndex: 0),
          ),
        );
      },
    );
  }
}
