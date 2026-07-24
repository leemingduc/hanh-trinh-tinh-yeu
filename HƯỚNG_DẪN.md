# 💕 Hành Trình Tình Yêu - Hướng Dẫn Sử Dụng

## 📱 Chạy Thử Nghiệm

### Chạy trên máy tính (Chrome):
```bash
flutter run -d chrome
```

### Chạy trên điện thoại (qua cùng WiFi):
1. Bật USB debugging trên điện thoại Android
2. Kết nối điện thoại với máy tính
3. Chạy lệnh:
```bash
flutter run -d <device-id>
```

Hoặc dùng Flutter DevTools để quét QR code.

---

## 🚀 Deploy Lên Internet (Miễn Phí)

### **Option 1: Vercel (Khuyến Nghị - Dễ Nhất)**

1. **Tạo tài khoản Vercel**: https://vercel.com/signup
2. **Cài Vercel CLI**:
```bash
npm install -g vercel
```

3. **Deploy**:
```bash
cd build/web
vercel
```

4. Làm theo hướng dẫn:
   - Set up and deploy? **Y**
   - Which scope? **Chọn account của bạn**
   - Link to existing project? **N**
   - Project name? **hanh-trinh-tinh-yeu** (hoặc tên bạn thích)
   - Directory? **./
   - Override settings? **N**

5. **Hoàn tất!** Vercel sẽ cho bạn URL dạng: `https://hanh-trinh-tinh-yeu.vercel.app`

---

### **Option 2: Netlify**

1. **Tạo tài khoản**: https://app.netlify.com/signup
2. **Kéo thả folder `build/web` vào**: https://app.netlify.com/drop
3. **Hoàn tất!** Netlify sẽ tạo URL ngẫu nhiên, bạn có thể đổi tên miền.

---

### **Option 3: GitHub Pages**

1. Tạo repository trên GitHub
2. Push code lên:
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

3. Build và deploy:
```bash
flutter build web --release --base-href "/<your-repo-name>/"
git subtree push --prefix build/web origin gh-pages
```

4. Bật GitHub Pages trong Settings → Pages → Source: **gh-pages branch**

---

## ✏️ Chỉnh Sửa Nội Dung

### **Thay đổi câu hỏi:**
Mở file `lib/config/challenge_data.dart` và sửa:

```dart
Challenge(
  id: 'challenge_1',
  title: 'Ký Ức Đầu Tiên',
  subtitle: 'Nhớ lại khoảnh khắc đặc biệt',
  icon: '💝',
  type: ChallengeType.quiz,
  question: 'Ngày đầu tiên mình chính thức yêu nhau là ngày nào?', // ← SỬA Ở ĐÂY
  options: [
    '29/6/2026',  // ← SỬA CÁC ĐÁP ÁN
    '30/6/2026',
    '1/7/2026',
  ],
  correctAnswers: [1], // ← Index đáp án đúng (0, 1, 2...)
  hint: 'Hãy nhớ lại khoảnh khắc đặc biệt đó nhé 💕',
  successMessage: 'Đúng rồi!...', // ← SỬA THÔNG BÁO
),
```

### **Thay đổi thư tình:**
Mở file `lib/config/gift_data.dart`:

```dart
final String loveLetter = '''
Bé yêu của anh,

Hôm nay là kỷ niệm 1 tháng mình yêu nhau...
// ← VIẾT THƯ CỦA BẠN Ở ĐÂY

Yêu bé nhiều,
Anh
''';
```

### **Thay đổi vouchers:**
Cũng trong `lib/config/gift_data.dart`:

```dart
final vouchers = [
  Voucher(
    icon: '🎁',
    title: 'Voucher Đặc Biệt',  // ← SỬA TIÊU ĐỀ
    description: 'Một bữa tối lãng mạn',  // ← SỬA MÔ TẢ
  ),
  // Thêm voucher khác...
];
```

### **Sau khi chỉnh sửa:**
```bash
# Build lại
flutter build web --release

# Deploy lại (nếu dùng Vercel)
cd build/web
vercel --prod
```

---

## 📱 Cài Đặt Như App Trên Điện Thoại

### **Trên Android (Chrome):**
1. Mở URL web trên Chrome
2. Nhấn menu (3 chấm) → **"Thêm vào Màn hình chính"**
3. Đặt tên → **Thêm**
4. Icon 💕 sẽ xuất hiện trên màn hình chính!

### **Trên iOS (Safari):**
1. Mở URL web trên Safari
2. Nhấn nút **Share** (hình vuông có mũi tên)
3. Chọn **"Thêm vào Màn hình chính"**
4. Đặt tên → **Thêm**

---

## 🎨 Tùy Chỉnh Màu Sắc

Mở file `lib/config/theme.dart`:

```dart
class AppTheme {
  // Màu chủ đạo - sửa ở đây
  static const Color primary = Color(0xFFFFB6C1);  // Hồng pastel
  static const Color secondary = Color(0xFFFFE4E9); // Hồng nhạt
  static const Color accent = Color(0xFFFFD700);    // Vàng gold
  
  // Gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFFF8F0), Color(0xFFFFE4E9)], // ← SỬA MÀU NỀN
  );
}
```

---

## 🐛 Khắc Phục Lỗi Thường Gặp

### **Lỗi: "Flutter not found"**
→ Cài Flutter SDK: https://flutter.dev/docs/get-started/install

### **Lỗi: "No devices found"**
→ Kết nối thiết bị hoặc chạy Chrome: `flutter run -d chrome`

### **Lỗi build: "Out of memory"**
→ Tăng RAM ảo hoặc đóng các ứng dụng khác

### **PWA không hiển thị icon**
→ Xóa cache trình duyệt và thử lại

---

## 📊 Cấu Trúc Dự Án

```
d:\love\
├── lib/
│   ├── main.dart                 # Điểm vào ứng dụng
│   ├── config/
│   │   ├── theme.dart           # Màu sắc, fonts
│   │   ├── challenge_data.dart  # ⭐ Câu hỏi (SỬA Ở ĐÂY)
│   │   └── gift_data.dart       # ⭐ Quà tặng (SỬA Ở ĐÂY)
│   ├── models/
│   │   ├── challenge.dart
│   │   ├── gift.dart
│   │   └── progress.dart
│   ├── widgets/
│   │   ├── particles_background.dart
│   │   ├── animated_button.dart
│   │   └── progress_bar.dart
│   ├── games/
│   │   ├── quiz_game.dart
│   │   ├── memory_game.dart
│   │   └── drag_drop_game.dart
│   └── screens/
│       ├── welcome_screen.dart
│       ├── challenge_screen.dart
│       └── reward_screen.dart
├── web/
│   ├── manifest.json            # PWA config
│   └── index.html
└── build/web/                   # ← DEPLOY FOLDER NÀY
```

---

## 💡 Tips Hay

### **Test trước khi gửi:**
1. Chạy `flutter run -d chrome`
2. Thử tất cả 5 thử thách
3. Kiểm tra animations có mượt không
4. Test trên điện thoại thật

### **Tạo QR Code để gửi bạn gái:**
1. Deploy lên Vercel
2. Vào https://www.qr-code-generator.com/
3. Dán URL Vercel vào
4. Tải QR code về
5. Gửi QR code cho bạn gái! 📱

### **Theo dõi lượt truy cập:**
- Vercel: Dashboard → Analytics
- Netlify: Site settings → Analytics

---

## 🎉 Chúc Mừng!

Bạn đã hoàn thành **"Hành Trình Tình Yêu"** - món quà kỷ niệm 1 tháng vô cùng ý nghĩa! 💕

Chúc bạn và người ấy có những khoảnh khắc thật đẹp bên nhau! 🌹

---

**Cần hỗ trợ?** Hãy xem tài liệu Flutter: https://flutter.dev/docs
