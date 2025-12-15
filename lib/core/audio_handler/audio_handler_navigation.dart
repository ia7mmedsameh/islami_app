class AudioHandlerNavigation {
  static Future<void> skipToNext({
    required int? currentSurahNumber,
    required Future<void> Function(int) playNextSurah,
    required Future<int?> Function() loadCurrentSurah,
  }) async {
    final surah = currentSurahNumber ?? await loadCurrentSurah();
    if (surah != null && surah < 114) {
      await playNextSurah(surah + 1);
    }
  }

  static Future<void> skipToPrevious({
    required int? currentSurahNumber,
    required Future<void> Function(int) playNextSurah,
    required Future<int?> Function() loadCurrentSurah,
  }) async {
    final surah = currentSurahNumber ?? await loadCurrentSurah();
    if (surah != null && surah > 1) {
      await playNextSurah(surah - 1);
    }
  }

  static Future<void> playNext({
    required int? currentSurahNumber,
    required Future<void> Function(int) playNextSurah,
  }) async {
    if (currentSurahNumber != null && currentSurahNumber < 114) {
      await playNextSurah(currentSurahNumber + 1);
    }
  }

  static Future<void> playPrevious({
    required int? currentSurahNumber,
    required Future<void> Function(int) playNextSurah,
  }) async {
    if (currentSurahNumber != null && currentSurahNumber > 1) {
      await playNextSurah(currentSurahNumber - 1);
    }
  }
}
