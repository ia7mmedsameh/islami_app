import 'package:audio_service/audio_service.dart';
import 'package:islami_app/features/radios/logic/audio_handler/radio_audio_handler.dart';
import 'package:islami_app/features/surah_details/logic/audio_handler/quran_audio_handler.dart';

class SuperAudioHandler extends BaseAudioHandler {
  final RadioAudioHandler radio;
  final QuranAudioHandler quran;

  SuperAudioHandler({
    required this.radio,
    required this.quran,
  });
}
