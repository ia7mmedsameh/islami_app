import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:islami_app/features/home/ui/widgets/color_linear_for_home_page.dart';
import 'package:islami_app/features/radios/data/models/radio_response_model.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_state.dart';
import 'package:islami_app/features/radios/ui/widgets/back_ground_for_radios_screen.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_list_item.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_player_container.dart';
import 'package:islami_app/features/radios/ui/widgets/radios_shimmer_loading.dart';

class RadiosListWidget extends StatelessWidget {
  const RadiosListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackGroundForRadiosScreen(),
        const ColorLinearForHomePage(),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: const IslamiLogoAndMosque(),
              ),
              Expanded(
                child: BlocBuilder<RadiosCubit, RadiosState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      radiosLoading: () => const RadiosShimmerLoading(),
                      radiosSuccess: (model) =>
                          RadiosListView(radios: model.radios ?? []),
                      radiosError: (message) => Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            message,
                            style: AppTextStyles.font16WhiteBold.copyWith(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
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
              return RadioListItem(
                radio: radio,
                isSelected: selectedRadio?.id == radio.id,
                onTap: () => setState(() => selectedRadio = radio),
              );
            },
            separatorBuilder: (_, __) => Divider(
              color: Colors.white.withOpacity(.2),
              indent: 20.w,
              endIndent: 20.w,
            ),
          ),
        ),
        if (selectedRadio != null)
          RadioPlayerContainer(
            key: ValueKey(selectedRadio!.id),
            radioUrl: selectedRadio!.url ?? '',
            radioName: selectedRadio!.name ?? '',
          ),
      ],
    );
  }
}
