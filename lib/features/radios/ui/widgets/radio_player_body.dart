import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_state.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_player_controls.dart';

class RadioPlayerBody extends StatelessWidget {
  final RadioState state;
  final String radioName;
  final String radioUrl;
  final List<dynamic>? radios;

  const RadioPlayerBody({
    super.key,
    required this.state,
    required this.radioName,
    required this.radioUrl,
    this.radios,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RadioCubit>();
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const Center(
        child: CircularProgressIndicator(color: ColorsManager.mainGold),
      ),
      playing: (volume) => RadioPlayerControls(
        radioName: radioName,
        radioUrl: radioUrl,
        isPlaying: true,
        volume: volume,
        cubit: cubit,
        radios: radios,
      ),
      paused: (volume) => RadioPlayerControls(
        radioName: radioName,
        radioUrl: radioUrl,
        isPlaying: false,
        volume: volume,
        cubit: cubit,
        radios: radios,
      ),
      error: (_) => Center(
        child: Text(
          "حدث خطأ في تشغيل $radioName",
          style: AppTextStyles.font16WhiteBold.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
