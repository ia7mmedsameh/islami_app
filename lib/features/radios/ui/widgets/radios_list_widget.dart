import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/radios/data/models/radio_response_model.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_state.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_state.dart';

class RadiosListWidget extends StatelessWidget {
  const RadiosListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadiosCubit, RadiosState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const SizedBox.shrink(),
          radiosLoading: () => const Center(
            child: CircularProgressIndicator(color: ColorsManager.mainGold),
          ),
          radiosSuccess: (radioResponseModel) {
            return RadiosListView(radios: radioResponseModel.radios ?? []);
          },
          radiosError: (message) => Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                message,
                style: AppTextStyles.font16WhiteBold.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class RadiosListView extends StatefulWidget {
  final List<RadioData> radios;

  const RadiosListView({super.key, required this.radios});

  @override
  State<RadiosListView> createState() => _RadiosListViewState();
}

class _RadiosListViewState extends State<RadiosListView> {
  RadioData? selectedRadio;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            itemCount: widget.radios.length,
            itemBuilder: (context, index) {
              final radio = widget.radios[index];
              final isSelected = selectedRadio?.id == radio.id;

              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                title: Text(
                  radio.name ?? '',
                  style: AppTextStyles.font16WhiteBold.copyWith(
                    color: isSelected ? ColorsManager.mainGold : Colors.white,
                  ),
                ),
                trailing: Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected
                      ? ColorsManager.mainGold
                      : Colors.grey.withOpacity(0.7),
                ),
                onTap: () {
                  setState(() => selectedRadio = radio);
                },
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withOpacity(.2),
              indent: 20.w,
              endIndent: 20.w,
            ),
          ),
        ),
        if (selectedRadio != null)
          _RadioPlayerContainer(
            key: ValueKey(selectedRadio!.id),
            radioUrl: selectedRadio!.url ?? '',
            radioName: selectedRadio!.name ?? '',
          ),
      ],
    );
  }
}

class _RadioPlayerContainer extends StatefulWidget {
  final String radioUrl;
  final String radioName;

  const _RadioPlayerContainer({
    super.key,
    required this.radioUrl,
    required this.radioName,
  });

  @override
  State<_RadioPlayerContainer> createState() => _RadioPlayerContainerState();
}

class _RadioPlayerContainerState extends State<_RadioPlayerContainer> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RadioCubit>().setRadio(
            widget.radioUrl,
            widget.radioName,
          );
    });
  }

  @override
  void didUpdateWidget(covariant _RadioPlayerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.radioUrl != widget.radioUrl) {
      context.read<RadioCubit>().setRadio(
            widget.radioUrl,
            widget.radioName,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioCubit, AudioState>(
      builder: (context, state) {
        final cubit = context.read<RadioCubit>();

        return Container(
          color: ColorsManager.black,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: state.maybeWhen(
            loading: () => Center(
              child: CircularProgressIndicator(color: ColorsManager.mainGold),
            ),
            success: (isPlaying, volume, _, __) =>
                _buildPlayer(cubit, isPlaying, volume),
            error: (msg) => Center(
              child: Text("حدث خطأ في تشغيل ${widget.radioName}",
                  style:
                      AppTextStyles.font16WhiteBold.copyWith(color: Colors.red)),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Widget _buildPlayer(RadioCubit cubit, bool isPlaying, double volume) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.radioName, style: AppTextStyles.font16WhiteBold),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                isPlaying ? cubit.pause() : cubit.resume();
              },
            ),
            IconButton(
              icon: Icon(
                volume == 0
                    ? Icons.volume_off
                    : volume < .3
                        ? Icons.volume_mute
                        : volume < .7
                            ? Icons.volume_down
                            : Icons.volume_up,
                color: Colors.white,
              ),
              onPressed: () => _openVolumeSheet(cubit, volume),
            )
          ],
        ),
      ],
    );
  }

  void _openVolumeSheet(RadioCubit cubit, double vol) {
    double currentVolume = vol;

    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.black,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setState) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("تحكم في الصوت",
                    style: AppTextStyles.font16WhiteBold),
                Slider(
                  min: 0,
                  max: 1,
                  value: currentVolume,
                  onChanged: (v) {
                    setState(() => currentVolume = v);
                    cubit.setVolume(v);
                  },
                  activeColor: ColorsManager.mainGold,
                  inactiveColor: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
