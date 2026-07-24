class Gift {
  final String id;
  final String title;
  final String icon;
  final String description;
  final GiftType type;
  final String? content; // Cho thư tình
  final bool isUsed;

  const Gift({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.type,
    this.content,
    this.isUsed = false,
  });

  Gift copyWith({bool? isUsed}) {
    return Gift(
      id: id,
      title: title,
      icon: icon,
      description: description,
      type: type,
      content: content,
      isUsed: isUsed ?? this.isUsed,
    );
  }
}

enum GiftType { loveLetter, voucher }
