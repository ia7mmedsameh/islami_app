import 'package:hive/hive.dart';

class RadioCubitMethods {
  static Future<void> updateAudioType() async {
    try {
      final box = await Hive.openBox('app_settings');
      await box.put('last_audio_type', 'radio');
    } catch (_) {}
  }
}
