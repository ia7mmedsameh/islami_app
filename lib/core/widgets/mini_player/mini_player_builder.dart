import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/widgets/mini_player/mini_player_content.dart';

class MiniPlayerBuilder {
  static Widget buildQuranPlayer(
    BuildContext context,
    int surahNumber,
    String surahName,
    bool isPlaying,
    Duration position,
    Duration total,
  ) {
    final manager = context.read<GlobalAudioManager>();
    return MiniPlayerContent(
      title: surahName,
      subtitle: _formatDuration(position, total),
      isPlaying: isPlaying,
      showProgress: true,
      progress: total.inSeconds > 0
          ? position.inSeconds / total.inSeconds
          : 0.0,
      icon: Icons.menu_book,
      onPlayPause: () => isPlaying ? manager.pause() : manager.resume(),
      onStop: () => manager.stop(),
      onTap: () => Navigator.pushNamed(
        context,
        '/surahDetailsScreen',
        arguments: surahNumber,
      ),
    );
  }

  static Widget buildRadioPlayer(
    BuildContext context,
    String radioName,
    bool isPlaying,
  ) {
    final manager = context.read<GlobalAudioManager>();
    return MiniPlayerContent(
      title: radioName,
      subtitle: "راديو مباشر",
      isPlaying: isPlaying,
      showProgress: false,
      progress: 0.0,
      icon: Icons.radio,
      onPlayPause: () => isPlaying ? manager.pause() : manager.resume(),
      onStop: () => manager.stop(),
    );
  }

  static String _formatDuration(Duration position, Duration total) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    if (total.inHours > 0) {
      return '${twoDigits(position.inHours)}:${twoDigits(position.inMinutes.remainder(60))}:${twoDigits(position.inSeconds.remainder(60))} / ${twoDigits(total.inHours)}:${twoDigits(total.inMinutes.remainder(60))}:${twoDigits(total.inSeconds.remainder(60))}';
    }
    return '${twoDigits(position.inMinutes.remainder(60))}:${twoDigits(position.inSeconds.remainder(60))} / ${twoDigits(total.inMinutes.remainder(60))}:${twoDigits(total.inSeconds.remainder(60))}';
  }
}
