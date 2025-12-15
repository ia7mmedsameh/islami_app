import 'package:flutter/material.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_volume_slider.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_repeat_popup.dart';
import 'package:islami_app/features/surah_details/ui/widgets/audio_controls/audio_controls_row.dart';

class AudioControls extends StatefulWidget {
  final bool isPlaying;
  final double volume;
  final AudioCubit audioCubit;
  final Function(int)? onNavigateToSurah;

  const AudioControls({
    super.key,
    required this.isPlaying,
    required this.volume,
    required this.audioCubit,
    this.onNavigateToSurah,
  });

  @override
  State<AudioControls> createState() => _AudioControlsState();
}

class _AudioControlsState extends State<AudioControls>
    with SingleTickerProviderStateMixin {
  bool _showVolumeSlider = false;
  bool _showRepeatMode = false;
  AnimationController? _repeatAnimController;
  Animation<double>? _repeatAnimation;

  @override
  void initState() {
    super.initState();
    _repeatAnimController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _repeatAnimation = CurvedAnimation(
      parent: _repeatAnimController!,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _repeatAnimController?.dispose();
    super.dispose();
  }

  void _onRepeatPressed() {
    widget.audioCubit.cycleRepeatMode();
    setState(() => _showRepeatMode = true);
    _repeatAnimController?.forward(from: 0);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _repeatAnimController?.reverse().then((_) {
          if (mounted) setState(() => _showRepeatMode = false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AudioControlsRow(
          isPlaying: widget.isPlaying,
          volume: widget.volume,
          audioCubit: widget.audioCubit,
          onNavigateToSurah: widget.onNavigateToSurah,
          onRepeatPressed: _onRepeatPressed,
          showVolumeSlider: _showVolumeSlider,
          onVolumeToggle: () =>
              setState(() => _showVolumeSlider = !_showVolumeSlider),
        ),
        if (_showRepeatMode && _repeatAnimation != null) ...[
          SizedBox(height: 12.h),
          AudioRepeatPopup(
            animation: _repeatAnimation!,
            repeatMode: widget.audioCubit.repeatMode,
          ),
        ],
        if (_showVolumeSlider) ...[
          SizedBox(height: 12.h),
          AudioVolumeSlider(
            volume: widget.volume,
            onChanged: widget.audioCubit.setVolume,
          ),
        ],
      ],
    );
  }
}
