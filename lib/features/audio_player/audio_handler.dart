import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class IslamiAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  IslamiAudioHandler() {
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      final oldMediaItem = mediaItem.value;
      if (oldMediaItem != null && duration != null) {
        mediaItem.add(oldMediaItem.copyWith(duration: duration));
      }
    });
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    // 💡 هذا السماع هو المسؤول عن تحديث الإشعار وإرسال تحديثات الموضع (position)
    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      playbackState.add(playbackState.value.copyWith(
        // ✅ التحكمات في الإشعار: Play/Pause و Stop فقط
        controls: [
          isPlaying ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
        ],
        
        // ✅ تفعيل Seek (شريط التقدم)
        systemActions: const {
          MediaAction.seek,
        },
        
        // ✅ زر Play/Pause هو الزر الوحيد في الوضع المضغوط
        androidCompactActionIndices: const [0], 
        
        processingState: {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.buffering,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[processingState] ?? AudioProcessingState.idle,
        
        // 💡 إرسال حالة اللعب والموضع والـ Buffer
        playing: isPlaying,
        bufferedPosition: _player.bufferedPosition,
        updatePosition: _player.position, // ✅ هذا هو مصدر تحديث شريط الـ Slider في الـ UI
      ));
    });
  }

  /// 🎧 تشغيل سورة جديدة (يتم استدعاؤها من الـ Cubit)
Future<void> playSurah(String url, String title) async {
    await _player.stop();
    
    // 1. ✅ الخطوة الأولى: إنشاء MediaItem وتحديثه فوراً.
    //    هذا هو الجزء الحاسم لظهور النوتفيكيشن
    mediaItem.add(
      MediaItem(
        id: url,
        title: title, // يعرض اسم السورة في الإشعار
        artist: 'القرآن الكريم',
      ),
    );

    // 2. ✅ الخطوة الثانية: تعيين مصدر الصوت.
    await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    
    // 3. ✅ الخطوة الثالثة: البدء بالتشغيل.
    await _player.play();
  }

  @override
  Future<void> play() async {
    // 💡 عند الانتهاء، يعود للصفر ثم يبدأ
    if (_player.processingState == ProcessingState.completed) {
      await _player.seek(Duration.zero);
    }
    return _player.play();
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    // الإيقاف النهائي للخدمة
    await _player.stop();
    await _player.dispose();
    return super.stop(); 
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  /// 🔊 التحكم في الصوت
  Future<void> setVolume(double volume) => _player.setVolume(volume);

  /// 💡 لإيقاف التشغيل وإزالة النوتفيكيشن عند الخروج من شاشة السورة
  Future<void> stopPlayer() async {
    await _player.stop();
    mediaItem.add(null); 
    playbackState.add(playbackState.value.copyWith(
      processingState: AudioProcessingState.idle,
      playing: false,
    ));
  }
}