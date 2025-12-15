import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/audio_manager/global_audio_state.dart';
import 'package:islami_app/core/widgets/mini_player/mini_player_builder.dart';

class MiniPlayer extends StatelessWidget {
  final int currentTabIndex;

  const MiniPlayer({super.key, required this.currentTabIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalAudioManager, GlobalAudioState>(
      builder: (context, state) {
        return state.maybeWhen(
          playingQuran:
              (surahNumber, surahName, isPlaying, volume, position, total) =>
                  MiniPlayerBuilder.buildQuranPlayer(
                    context,
                    surahNumber,
                    surahName,
                    isPlaying,
                    position,
                    total,
                  ),
          playingRadio: (radioUrl, radioName, isPlaying, volume) {
            if (currentTabIndex == 3) return const SizedBox.shrink();
            return MiniPlayerBuilder.buildRadioPlayer(
              context,
              radioName,
              isPlaying,
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
