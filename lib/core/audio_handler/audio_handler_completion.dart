import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:islami_app/core/audio_handler/audio_handler_storage.dart';
import 'package:just_audio/just_audio.dart';

class AudioHandlerCompletion {
  static Future<void> handle(
    PlayerState state,
    bool isLiveStream,
    int? currentSurahNumber,
    RepeatMode repeatMode,
    AudioPlayer player,
    Future<void> Function(int) playNextSurah,
  ) async {
    if (state.processingState == ProcessingState.completed &&
        !isLiveStream &&
        currentSurahNumber != null) {
      if (repeatMode == RepeatMode.one) {
        await player.seek(Duration.zero);
        await player.play();
      } else if (repeatMode == RepeatMode.all) {
        final next = currentSurahNumber + 1;
        await playNextSurah(next <= 114 ? next : 1);
      } else {
        await player.seek(Duration.zero);
        await player.pause();
      }
    }
  }

  static Future<void> playNextSurah(
    int surahNumber,
    AudioPlayer player,
    Future<void> Function({
      required String url,
      required String surahName,
      required int surahNumber,
      bool autoPlay,
    })
    setQuranMedia,
    void Function(int) addNavigation,
  ) async {
    final name = await AudioHandlerStorage.getSurahName(surahNumber);
    final url =
        'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/$surahNumber.mp3';
    await player.stop();
    await Future.delayed(const Duration(milliseconds: 300));
    await setQuranMedia(url: url, surahName: name, surahNumber: surahNumber);
    addNavigation(surahNumber);
  }
}
