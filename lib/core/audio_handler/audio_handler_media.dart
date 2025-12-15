import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio/just_audio.dart';
import 'package:islami_app/core/audio_handler/audio_handler_storage.dart';

class AudioHandlerMedia {
  static Future<void> playRadio({
    required AudioPlayer player,
    required BehaviorSubject<MediaItem?> mediaItem,
    required String url,
    required String name,
    required void Function(bool) setLiveStream,
  }) async {
    setLiveStream(true);
    mediaItem.add(
      MediaItem(id: url, title: name, artist: "راديو", playable: true),
    );
    await player.setUrl(url);
    await player.play();
  }

  static Future<void> setQuranMedia({
    required AudioPlayer player,
    required BehaviorSubject<MediaItem?> mediaItem,
    required String url,
    required String surahName,
    required int surahNumber,
    required void Function(bool) setLiveStream,
    required void Function(int) setSurahNumber,
    required void Function() broadcastState,
    bool autoPlay = true,
  }) async {
    setLiveStream(false);
    setSurahNumber(surahNumber);
    await AudioHandlerStorage.savePlayback(
      surahNumber,
      Duration.zero,
      surahName,
    );
    mediaItem.add(
      MediaItem(
        id: url,
        title: surahName,
        artist: "تلاوة القرآن الكريم",
        album: "سورة رقم $surahNumber",
        playable: true,
      ),
    );
    final duration = await player.setUrl(url);
    if (duration != null) {
      mediaItem.add(
        MediaItem(
          id: url,
          title: surahName,
          artist: "تلاوة القرآن الكريم",
          album: "سورة رقم $surahNumber",
          duration: duration,
          playable: true,
        ),
      );
    }
    if (autoPlay) await player.play();
    broadcastState();
  }
}
