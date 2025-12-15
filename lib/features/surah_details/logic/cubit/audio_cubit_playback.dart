import 'package:hive/hive.dart';
import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:just_audio/just_audio.dart';

class AudioCubitPlayback {
  static Future<void> saveState(
    RadioAudioHandler handler,
    AudioPlayer player,
  ) async {
    try {
      final box = await Hive.openBox('app_settings');
      await box.put('last_surah_number', handler.currentSurahNumber);
      await box.put('last_surah_position', player.position.inMilliseconds);
      await box.put('last_audio_type', 'quran');
    } catch (_) {}
  }

  static Future<int> loadLastSurah() async {
    try {
      final box = await Hive.openBox('app_settings');
      return box.get('last_surah_number', defaultValue: 1);
    } catch (_) {
      return 1;
    }
  }

  static Future<void> restorePosition(
    RadioAudioHandler handler,
    AudioPlayer player,
  ) async {
    try {
      final box = await Hive.openBox('app_settings');
      final lastSurahNumber = box.get('last_surah_number');
      final lastPosition = box.get('last_surah_position', defaultValue: 0);
      final lastAudioType = box.get('last_audio_type', defaultValue: 'quran');
      if (lastSurahNumber == handler.currentSurahNumber &&
          lastPosition > 1000 &&
          lastAudioType == 'quran') {
        await Future.delayed(const Duration(milliseconds: 300));
        if (player.processingState == ProcessingState.ready) {
          await player.seek(Duration(milliseconds: lastPosition));
        }
      }
    } catch (_) {}
  }
}
