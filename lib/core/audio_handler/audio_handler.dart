import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:islami_app/core/audio_handler/audio_handler_playback.dart';
import 'package:islami_app/core/audio_handler/audio_handler_storage.dart';
import 'package:islami_app/core/audio_handler/audio_handler_completion.dart';

enum RepeatMode { off, one, all }

class RadioAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player;
  bool _isLiveStream = false;
  RepeatMode _repeatMode = RepeatMode.all;
  int? _currentSurahNumber;
  final _navigationController = StreamController<int>.broadcast();

  Stream<int> get navigationStream => _navigationController.stream;
  AudioPlayer get player => _player;
  RepeatMode get repeatMode => _repeatMode;
  bool get isRepeatEnabled => _repeatMode != RepeatMode.off;
  int? get currentSurahNumber => _currentSurahNumber;

  RadioAudioHandler(this._player) {
    _init();
  }

  Future<void> _init() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
    } catch (_) {}
    _setupListeners();
  }

  void _setupListeners() {
    _player.playerStateStream.listen((state) {
      broadcastState(
        state,
        _isLiveStream,
        _currentSurahNumber,
        _player,
        playbackState,
      );
      AudioHandlerCompletion.handle(
        state,
        _isLiveStream,
        _currentSurahNumber,
        _repeatMode,
        _player,
        _playNextSurah,
      );
    });
    _player.positionStream.listen((_) {
      if (!_isLiveStream) {
        broadcastState(
          _player.playerState,
          _isLiveStream,
          _currentSurahNumber,
          _player,
          playbackState,
        );
      }
    });
  }

  Future<void> _playNextSurah(int surahNumber) async =>
      await AudioHandlerCompletion.playNextSurah(
        surahNumber,
        _player,
        setQuranMedia,
        _navigationController.add,
      );

  Future<void> playRadio(String url, String name) async {
    _isLiveStream = true;
    mediaItem.add(
      MediaItem(id: url, title: name, artist: "راديو", playable: true),
    );
    await _player.setUrl(url);
    await _player.play();
  }

  Future<void> setQuranMedia({
    required String url,
    required String surahName,
    required int surahNumber,
    bool autoPlay = true,
  }) async {
    _isLiveStream = false;
    _currentSurahNumber = surahNumber;
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
    final duration = await _player.setUrl(url);
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
    if (autoPlay) await _player.play();
    broadcastState(
      _player.playerState,
      _isLiveStream,
      _currentSurahNumber,
      _player,
      playbackState,
    );
  }

  @override
  Future<void> skipToNext() async {
    _currentSurahNumber ??= await AudioHandlerStorage.loadCurrentSurah();
    if (_currentSurahNumber != null && _currentSurahNumber! < 114) {
      await _playNextSurah(_currentSurahNumber! + 1);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    _currentSurahNumber ??= await AudioHandlerStorage.loadCurrentSurah();
    if (_currentSurahNumber != null && _currentSurahNumber! > 1) {
      await _playNextSurah(_currentSurahNumber! - 1);
    }
  }

  @override
  Future<void> onTaskRemoved() async {
    if (!_player.playing) await stop();
    await _navigationController.close();
  }

  @override
  Future<void> play() => _player.play();
  @override
  Future<void> pause() async {
    await _player.pause();
    broadcastState(
      _player.playerState,
      _isLiveStream,
      _currentSurahNumber,
      _player,
      playbackState,
    );
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);
  @override
  Future<void> stop() async {
    await _player.stop();
    mediaItem.add(null);
    await super.stop();
  }

  Future<void> setVolume(double v) => _player.setVolume(v);
  void cycleRepeatMode() {
    _repeatMode = _repeatMode == RepeatMode.off
        ? RepeatMode.one
        : (_repeatMode == RepeatMode.one ? RepeatMode.all : RepeatMode.off);
  }

  void setQuranRepeatMode(RepeatMode mode) => _repeatMode = mode;
  Future<void> playNext() async {
    if (_currentSurahNumber != null && _currentSurahNumber! < 114) {
      await _playNextSurah(_currentSurahNumber! + 1);
    }
  }

  Future<void> playPrevious() async {
    if (_currentSurahNumber != null && _currentSurahNumber! > 1) {
      await _playNextSurah(_currentSurahNumber! - 1);
    }
  }
}
