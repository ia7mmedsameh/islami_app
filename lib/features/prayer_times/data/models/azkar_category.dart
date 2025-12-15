class AzkarCategory {
  final String nameAr;
  final String nameEn;
  final String apiKey;
  final String icon;

  const AzkarCategory({
    required this.nameAr,
    required this.nameEn,
    required this.apiKey,
    required this.icon,
  });

  static const List<AzkarCategory> allCategories = [
    AzkarCategory(
      nameAr: 'أذكار الصباح',
      nameEn: 'Morning Azkar',
      apiKey: 'أذكار الصباح',
      icon: 'morning',
    ),
    AzkarCategory(
      nameAr: 'أذكار المساء',
      nameEn: 'Evening Azkar',
      apiKey: 'أذكار المساء',
      icon: 'evening',
    ),
    AzkarCategory(
      nameAr: 'أذكار بعد الصلاة',
      nameEn: 'Post-Prayer Azkar',
      apiKey: 'أذكار بعد السلام من الصلاة المفروضة',
      icon: 'prayer',
    ),
    AzkarCategory(
      nameAr: 'تسابيح',
      nameEn: 'Tasbeeh',
      apiKey: 'تسابيح',
      icon: 'tasbeeh',
    ),
    AzkarCategory(
      nameAr: 'أذكار النوم',
      nameEn: 'Sleep Azkar',
      apiKey: 'أذكار النوم',
      icon: 'sleep',
    ),
    AzkarCategory(
      nameAr: 'أذكار الاستيقاظ',
      nameEn: 'Waking Up Azkar',
      apiKey: 'أذكار الاستيقاظ',
      icon: 'wakeup',
    ),
    AzkarCategory(
      nameAr: 'أدعية قرآنية',
      nameEn: 'Quranic Duas',
      apiKey: 'أدعية قرآنية',
      icon: 'quran',
    ),
    AzkarCategory(
      nameAr: 'أدعية الأنبياء',
      nameEn: 'Prophets Duas',
      apiKey: 'أدعية الأنبياء',
      icon: 'prophets',
    ),
  ];
}
