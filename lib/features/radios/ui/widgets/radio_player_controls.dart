import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_player_header.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_player_buttons.dart';

class RadioPlayerControls extends StatefulWidget {
  final String radioName;
  final String radioUrl;
  final bool isPlaying;
  final double volume;
  final RadioCubit cubit;
  final List<dynamic>? radios;

  const RadioPlayerControls({
    super.key,
    required this.radioName,
    required this.radioUrl,
    required this.isPlaying,
    required this.volume,
    required this.cubit,
    this.radios,
  });

  @override
  State<RadioPlayerControls> createState() => _RadioPlayerControlsState();
}

class _RadioPlayerControlsState extends State<RadioPlayerControls> {
  bool _showVolumeSlider = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioPlayerHeader(radioName: widget.radioName),
        SizedBox(height: 16.h),
        RadioPlayerButtons(
          isPlaying: widget.isPlaying,
          volume: widget.volume,
          cubit: widget.cubit,
          radios: widget.radios,
          radioUrl: widget.radioUrl,
          showVolumeSlider: _showVolumeSlider,
          onVolumeToggle: () =>
              setState(() => _showVolumeSlider = !_showVolumeSlider),
        ),
      ],
    );
  }
}
