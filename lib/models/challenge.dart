enum ChallengeType {
  quiz, // Câu hỏi trắc nghiệm
  multiSelect, // Chọn nhiều đáp án
  memory, // Trò chơi ghép thẻ
  dragDrop, // Kéo thả sắp xếp
  special, // Câu hỏi đặc biệt
}

class Challenge {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final ChallengeType type;
  final String question;
  final List<String> options;
  final List<int> correctAnswers; // Index của đáp án đúng
  final String hint;
  final String successMessage;

  /// true = chọn bất kỳ 1 đáp án nào cũng đúng (dùng cho thử thách đặc biệt)
  final bool anyOptionCorrect;

  /// Các tổ hợp đáp án hợp lệ khác ngoài correctAnswers
  /// Ví dụ: [[3]] = chỉ cần chọn đáp án index 3 cũng OK
  final List<List<int>> alternativeCorrectSets;

  const Challenge({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswers,
    required this.hint,
    required this.successMessage,
    this.anyOptionCorrect = false,
    this.alternativeCorrectSets = const [],
  });

  bool isAnswerCorrect(List<int> selectedAnswers) {
    // Trường hợp đặc biệt: chọn bất kỳ đáp án nào cũng đúng
    if (anyOptionCorrect) {
      return selectedAnswers.length == 1;
    }

    // Kiểm tra correctAnswers chính
    if (_setEquals(selectedAnswers, correctAnswers)) return true;

    // Kiểm tra các tổ hợp thay thế
    for (final altSet in alternativeCorrectSets) {
      if (_setEquals(selectedAnswers, altSet)) return true;
    }

    return false;
  }

  bool _setEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int item in b) {
      if (!a.contains(item)) return false;
    }
    return true;
  }
}

class MemoryCard {
  final String id;
  final String emoji;
  final int pairId;
  bool isFlipped;
  bool isMatched;

  MemoryCard({
    required this.id,
    required this.emoji,
    required this.pairId,
    this.isFlipped = false,
    this.isMatched = false,
  });

  MemoryCard copyWith({bool? isFlipped, bool? isMatched}) {
    return MemoryCard(
      id: id,
      emoji: emoji,
      pairId: pairId,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}

class TimelineEvent {
  final String id;
  final String title;
  final String date;
  final String icon;
  final int correctOrder;

  const TimelineEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.icon,
    required this.correctOrder,
  });
}
