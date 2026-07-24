# Hành Trình Tình Yêu - Thiết Kế Chi Tiết

## Tổng Quan
- **Mục đích:** Web quà tặng kỷ niệm 1 tháng yêu nhau (30/6 - 30/7/2026)
- **Đối tượng:** Bạn gái ("Bé") từ bạn trai ("Anh")
- **Ngôn ngữ:** 100% Tiếng Việt
- **Nền tảng:** Flutter Web + PWA, tối ưu mobile-first

## Theme & Thiết Kế
- **Màu chủ đạo:** Hồng pastel (#FFB6C1, #FFE4E9) + Trắng kem (#FFF8F0) + Vàng gold (#FFD700)
- **Phong cách:** Minimalist lãng mạn, bo tròn, shadows nhẹ
- **Hiệu ứng:** Particles trái tim, confetti, animations 60fps

## Luồng Trải Nghiệm
1. **Màn hình chào mừng** → Hiệu ứng trái tim bay, nút "Bắt Đầu Hành Trình"
2. **5 Thử thách liên tiếp** → Mỗi thử thách vượt qua nhận 1 chìa khóa
3. **Màn hình mở khóa** → 5 chìa khóa mở cánh cửa trái tim
4. **Quà tặng** → Thư tình + 3 Vouchers

## 5 Thử Thách
1. **Ký Ức Đầu Tiên** - Trắc nghiệm: Ngày đầu yêu nhau
2. **Ghép Đôi Trái Tim** - Memory game: Lật thẻ ghép cặp
3. **Lời Ngọt Ngào** - Chọn tất cả đáp án đúng về lý do yêu
4. **Dòng Thời Gian** - Drag & drop sắp xếp sự kiện
5. **Câu Hỏi Cuối Cùng** - "Bé có yêu anh không?" (tất cả đều đúng)

## Quà Tặng
- **Thư tình kỹ thuật số** - Hiệu ứng mở phong bì
- **3 Phiếu quà tặng** - "1 bữa tối anh nấu", "1 buổi xem phim", "1 cái ôm không buông"

## Cấu Trúc Kỹ Thuật
- Flutter Web + PWA
- State management: Provider
- Animation: flutter_animate, confetti_widget
- Storage: shared_preferences (lưu progress)
- Mobile-first: Touch targets ≥ 48px, responsive layout

## Dữ Liệu Tùy Chỉnh
- File `challenge_data.dart` - Chỉnh sửa câu hỏi
- File `gift_data.dart` - Chỉnh sửa thư tình & vouchers

## Triển Khai
- Deploy lên Vercel/Netlify (miễn phí hosting)
- PWA: Add to Home Screen, offline cache
- Icon hình trái tim trên màn hình chính
