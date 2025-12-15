import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/audio_manager/global_audio_state.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_state.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_player_body.dart';

class RadioPlayerContainer extends StatefulWidget {
  final String radioUrl;
  final String radioName;
  final List<dynamic>? radios;

  const RadioPlayerContainer({
    super.key,
    required this.radioUrl,
    required this.radioName,
    this.radios,
  });

  @override
  State<RadioPlayerContainer> createState() => _RadioPlayerContainerState();
}

class _RadioPlayerContainerState extends State<RadioPlayerContainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndSetRadio());
  }

  @override
  void didUpdateWidget(RadioPlayerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.radioUrl != widget.radioUrl) {
      context.read<RadioCubit>().setRadio(widget.radioUrl, widget.radioName);
    }
  }

  void _checkAndSetRadio() {
    final globalState = getIt<GlobalAudioManager>().state;
    final isSameRadioPlaying =
        globalState is PlayingRadio && globalState.radioUrl == widget.radioUrl;
    if (!isSameRadioPlaying) {
      context.read<RadioCubit>().setRadio(widget.radioUrl, widget.radioName);
    } else {
      context.read<RadioCubit>().connectToExistingPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalAudioManager, GlobalAudioState>(
      builder: (context, globalState) {
        String currentRadioName = widget.radioName;
        String currentRadioUrl = widget.radioUrl;
        if (globalState is PlayingRadio) {
          currentRadioName = globalState.radioName;
          currentRadioUrl = globalState.radioUrl;
        }
        return BlocBuilder<RadioCubit, RadioState>(
          builder: (context, state) => Container(
            color: ColorsManager.black,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioPlayerBody(
                  state: state,
                  radioName: currentRadioName,
                  radioUrl: currentRadioUrl,
                  radios: widget.radios,
                ),
                SizedBox(height: 8.h),
                Text(
                  'بث إذاعات القرآن الكريم يتم عبر واجهة mp3quran.net',
                  style: TextStyle(color: ColorsManager.gray, fontSize: 10.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
