import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_state.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_player_controls.dart';

class RadioPlayerContainer extends StatefulWidget {
  final String radioUrl;
  final String radioName;

  const RadioPlayerContainer({
    super.key,
    required this.radioUrl,
    required this.radioName,
  });

  @override
  State<RadioPlayerContainer> createState() => _RadioPlayerContainerState();
}

class _RadioPlayerContainerState extends State<RadioPlayerContainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RadioCubit>().setRadio(widget.radioUrl, widget.radioName);
    });
  }

  @override
  void didUpdateWidget(RadioPlayerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.radioUrl != widget.radioUrl) {
      context.read<RadioCubit>().setRadio(widget.radioUrl, widget.radioName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioCubit, RadioState>(
      builder: (context, state) {
        final cubit = context.read<RadioCubit>();
        return Container(
          color: ColorsManager.black,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(color: ColorsManager.mainGold),
            ),
            playing: (volume) => RadioPlayerControls(
              radioName: widget.radioName,
              isPlaying: true,
              volume: volume,
              cubit: cubit,
            ),
            paused: (volume) => RadioPlayerControls(
              radioName: widget.radioName,
              isPlaying: false,
              volume: volume,
              cubit: cubit,
            ),
            error: (_) => Center(
              child: Text(
                "حدث خطأ في تشغيل ${widget.radioName}",
                style: AppTextStyles.font16WhiteBold.copyWith(color: Colors.red),
              ),
            ),
          ),
        );
      },
    );
  }
}

