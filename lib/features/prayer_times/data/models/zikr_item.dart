class ZikrItem {
  final String? content;
  final String? count;
  final String? description;
  final String? reference;
  final String? category;

  ZikrItem({
    this.content,
    this.count,
    this.description,
    this.reference,
    this.category,
  });

  factory ZikrItem.fromJson(Map<String, dynamic> json) => ZikrItem(
    content: json['content']?.toString(),
    count: json['count']?.toString(),
    description: json['description']?.toString(),
    reference: json['reference']?.toString(),
    category: json['category']?.toString(),
  );

  String get cleanContent => _cleanText(content ?? '');
  String get cleanCount => _cleanText(count ?? '');
  String get cleanDescription => _cleanText(description ?? '');
  String get cleanReference => _cleanText(reference ?? '');

  static String _cleanText(String text) {
    if (text.isEmpty) return '';
    return text
        .replaceAll(r'\n', ' ')
        .replaceAll(r"\'", "'")
        .replaceAll(r'\"', '"')
        .replaceAll("', '", ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
