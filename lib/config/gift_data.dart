import '../models/gift.dart';

// ============================================================
// CHỈNH SỬA QUÀ TẶNG Ở ĐÂY
// ============================================================
// Bạn có thể thay đổi nội dung thư tình và vouchers
// ============================================================

// Thư tình kỹ thuật số
final String loveLetterContent = '''
Gửi cô bé iuu dấu của anh,

Hôm nay là kỷ niệm 1 tháng mình yêu nhau đó - một hành trình thật đẹp và ý nghĩa. 

Từ ngày 30/6 đến giờ, mỗi ngày bên em đều là một món quà tuyệt vời với anh. Cảm ơn em đã đến và làm cuộc đời anh thêm rực rỡ.

Anh biết 1 tháng chưa phải là dài, nhưng với anh, đó là 30 ngày hạnh phúc nhất. Cũng cảm ơn em đã luôn ở bên, đã yêu thương và tin tưởng anh.

Anh hứa sẽ luôn cố gắng để trở thành người đàn ông tốt nhất cho em. Sẽ luôn ở bên, lắng nghe và yêu thương em mỗi ngày.

Chúc mừng kỷ niệm 1 tháng của chúng mình! Hãy cùng nhau đi tiếp thật nhiều tháng, thật nhiều năm nữa nha bé!

Mong là sau này, khi đọc lại lá thư này, em sẽ mỉm cười và nhớ về những khoảnh khắc tuyệt vời mà chúng ta đã trải qua nhé, hì hì.

Em chính là tất cả của anh, là niềm vui, là hạnh phúc, là lý do để anh cố gắng mỗi ngày. Anh yêu em nhiều lắm, iuu iuuu 💖

Yêu em nhiều lắm! 💕

Mãi là em bé của anh nha hihi 😘
Chồng tương lai của em💖.
Iuu Iuuuuu
''';

// Danh sách vouchers quà tặng
final List<Gift> vouchersData = [
  Gift(
    id: 'voucher_1',
    title: 'Bữa Tối Đặc Biệt',
    icon: '🍝',
    description: '1 phiếu bữa tối do chính tay anh nấu',
    type: GiftType.voucher,
  ),
  Gift(
    id: 'voucher_2',
    title: 'Buổi Xem Phim',
    icon: '🎬',
    description: '1 phiếu đi xem phim cùng nhau',
    type: GiftType.voucher,
  ),
  Gift(
    id: 'voucher_3',
    title: 'Cái Ôm Không Buông',
    icon: '🤗',
    description: 'Phiếu 1 cái ôm thật chặt không buông',
    type: GiftType.voucher,
  ),
];

// Quà tặng tổng hợp
final List<Gift> allGifts = [
  Gift(
    id: 'love_letter',
    title: 'Thư Tình',
    icon: '💌',
    description: 'Lá thư tình từ trái tim anh',
    type: GiftType.loveLetter,
    content: loveLetterContent,
  ),
  ...vouchersData,
];
