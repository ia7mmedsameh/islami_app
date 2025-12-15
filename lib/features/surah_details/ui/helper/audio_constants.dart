class AudioConstants {
  static const String defaultEdition = "ar.alafasy";
  static const String baseUrl = "https://cdn.islamic.network/quran/audio-surah";

  // Available bitrates to try
  static const List<int> bitrates = [128, 64, 192, 48, 32];

  static String getSurahUrl({
    required int surahNumber,
    required String edition,
    int bitrate = 128,
  }) {
    return '$baseUrl/$bitrate/$edition/$surahNumber.mp3';
  }

  /// Get all possible URLs for a reciter (different bitrates)
  static List<String> getAllPossibleUrls({
    required int surahNumber,
    required String edition,
  }) {
    return bitrates
        .map(
          (b) => getSurahUrl(
            surahNumber: surahNumber,
            edition: edition,
            bitrate: b,
          ),
        )
        .toList();
  }
}
