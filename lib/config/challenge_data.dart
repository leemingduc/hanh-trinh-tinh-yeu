import '../models/challenge.dart';

// ============================================================
// CHỈNH SỬA CÂU HỎI Ở ĐÂY
// ============================================================
// Bạn có thể thay đổi nội dung câu hỏi, đáp án, gợi ý
// correctAnswers là index của đáp án đúng (bắt đầu từ 0)
// ============================================================

final List<Challenge> challengeData = [
  // Thử thách 1: Ký Ức Đầu Tiên
  Challenge(
    id: 'challenge_1',
    title: 'Ký Ức Đầu Tiên',
    subtitle: 'Nhớ lại khoảnh khắc đặc biệt',
    icon: '💝',
    type: ChallengeType.quiz,
    question: 'Ngày đầu tiên mình chính thức yêu nhau là ngày nào?',
    options: ['29/6/2026', '30/6/2026', '1/7/2026', '28/6/2026'],
    correctAnswers: [1], // Index 1 = "30/6/2026"
    hint: 'Hãy nhớ lại khoảnh khắc đặc biệt đó nhé 💕',
    successMessage:
        'Đúng rồi! Ngày 30/6/2026 là ngày đẹp nhất trong cuộc đời anh 🥰',
  ),

  // Thử thách 2: Ghép Đôi Trái Tim (Memory Game)
  Challenge(
    id: 'challenge_2',
    title: 'Ghép Đôi Trái Tim',
    subtitle: 'Tìm những cặp đôi yêu thương',
    icon: '💕',
    type: ChallengeType.memory,
    question: 'Lật các thẻ và ghép những cặp giống nhau nhé!',
    options: [], // Memory game không dùng options
    correctAnswers: [], // Memory game xử lý riêng
    hint: 'Cố lên bé! Hãy nhớ vị trí của từng thẻ nhé 🧠💖',
    successMessage: 'Tuyệt vời! Bé thật thông minh 🎉',
  ),

  // Thử thách 3: Lời Ngọt Ngào (Multi-select)
  Challenge(
    id: 'challenge_3',
    title: 'Lời Ngọt Ngào',
    subtitle: 'Điều gì khiến bé đặc biệt?',
    icon: '🌹',
    type: ChallengeType.multiSelect,
    question: 'Điều gì khiến anh yêu bé nhất? (Chọn tất cả đáp án đúng)',
    options: [
      'Xinh gái, cute, chuẩn gu anh ☀️',
      'Giọng bé ngọt lịm, dễ thương, nghe là muốn iu lun 😤',
      'Bé luôn ở bên cạnh anh, luôn yêu anh 💕',
      'Tất cả những điều trên đều đúng! 💝',
    ],
    correctAnswers: [0, 1, 2, 3], // Tất cả đều đúng
    alternativeCorrectSets: [
      [3], // Chỉ cần chọn "Tất cả đều đúng" cũng OK
    ],
    hint: 'Hãy chọn tất cả những điều khiến bé đặc biệt nhé! ✨',
    successMessage:
        'Đúng rồi! Tất cả đều khiến anh yêu bé nhiều hơn mỗi ngày, em là ngoại lệ của anh đó nha 💖',
  ),

  // Thử thách 4: Dòng Thời Gian (Drag & Drop)
  Challenge(
    id: 'challenge_4',
    title: 'Dòng Thời Gian',
    subtitle: 'Sắp xếp những khoảnh khắc đẹp',
    icon: '📅',
    type: ChallengeType.dragDrop,
    question: 'Kéo thả các sự kiện theo đúng thứ tự thời gian nhé!',
    options: [], // Drag & drop dùng TimelineEvent riêng
    correctAnswers: [], // Drag & drop xử lý riêng
    hint: 'Hãy nhớ lại hành trình của chúng mình từ đầu đến giờ nhé 💫',
    successMessage: 'Hoàn hảo! Hành trình của chúng mình thật đẹp 🌈',
  ),

  // Thử thách 5: Câu Hỏi Cuối Cùng (Special)
  Challenge(
    id: 'challenge_5',
    title: 'Câu Hỏi Cuối Cùng',
    subtitle: 'Điều quan trọng nhất',
    icon: '💖',
    type: ChallengeType.special,
    question: 'Bé có yêu anh không?',
    options: [
      'Có 💕',
      'Rất nhiều 💖',
      'Nhiều hơn anh nghĩ 💝',
      'Yêu anh nhất trên đời 💗',
    ],
    correctAnswers: [0, 1, 2, 3], // Tất cả đều đúng
    anyOptionCorrect: true, // Chọn bất kỳ đáp án nào cũng đúng
    hint: 'Anh biết câu trả lời mà! 😊',
    successMessage: 'Anh cũng yêu bé nhiều lắm! Mãi mãi bên nhau nha 💕',
  ),
];

// Dữ liệu cho trò chơi Memory (Thử thách 2)
final List<MemoryCard> memoryCardsData = [
  MemoryCard(id: 'card_1a', emoji: '💕', pairId: 1),
  MemoryCard(id: 'card_1b', emoji: '💕', pairId: 1),
  MemoryCard(id: 'card_2a', emoji: '💖', pairId: 2),
  MemoryCard(id: 'card_2b', emoji: '💖', pairId: 2),
  MemoryCard(id: 'card_3a', emoji: '🌹', pairId: 3),
  MemoryCard(id: 'card_3b', emoji: '🌹', pairId: 3),
  MemoryCard(id: 'card_4a', emoji: '💝', pairId: 4),
  MemoryCard(id: 'card_4b', emoji: '💝', pairId: 4),
];

// Dữ liệu cho trò chơi Drag & Drop (Thử thách 4)
final List<TimelineEvent> timelineEventsData = [
  TimelineEvent(
    id: 'event_1',
    title: 'Ngày anh vào nhóm hát',
    date: 'Giữa tháng 5/2026',
    icon: '🎤',
    correctOrder: 1,
  ),
  TimelineEvent(
    id: 'event_2',
    title: 'Ngày anh follow TikTok rồi nói chuyện với bé',
    date: '28/5/2026',
    icon: '📱',
    correctOrder: 2,
  ),
  TimelineEvent(
    id: 'event_3',
    title: 'Ngày anh xin được Facebook của bé',
    date: '3/6/2026',
    icon: '💬',
    correctOrder: 3,
  ),
  TimelineEvent(
    id: 'event_4',
    title: 'Bắt đầu xác nhận mối quan hệ',
    date: '30/6/2026',
    icon: '💕',
    correctOrder: 4,
  ),
  TimelineEvent(
    id: 'event_5',
    title: 'Kỉ niệm 1 tháng yêu nhau',
    date: '30/7/2026',
    icon: '🎉',
    correctOrder: 5,
  ),
];
