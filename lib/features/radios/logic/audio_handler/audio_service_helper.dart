import 'package:islami_app/features/radios/logic/audio_handler/radio_audio_handler.dart';
import 'package:islami_app/core/di/dependency_injection.dart';

class AudioServiceHelper {
  static RadioAudioHandler get handler => getIt<RadioAudioHandler>();
}
