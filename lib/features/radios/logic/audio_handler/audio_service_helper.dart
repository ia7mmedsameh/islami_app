import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:islami_app/core/di/dependency_injection.dart';

class AudioServiceHelper {
  static RadioAudioHandler get handler => getIt<RadioAudioHandler>();
}
