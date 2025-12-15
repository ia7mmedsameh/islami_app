import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/features/radios/data/models/radio_response_model.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_state.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_list_item.dart';
import 'package:islami_app/features/radios/ui/widgets/radios_shimmer_loading.dart';

class RadiosListBody extends StatelessWidget {
  final RadiosState state;
  final List<RadioData> allRadios;
  final List<RadioData> searchedRadios;
  final String searchText;
  final Function(List<RadioData>) onRadiosLoaded;
  final Function(RadioData) onRadioSelected;
  final RadioData? selectedRadio;

  const RadiosListBody({
    super.key,
    required this.state,
    required this.allRadios,
    required this.searchedRadios,
    required this.searchText,
    required this.onRadiosLoaded,
    required this.onRadioSelected,
    required this.selectedRadio,
  });

  @override
  Widget build(BuildContext context) {
    return state.maybeWhen(
      radiosLoading: () => const RadiosShimmerLoading(),
      radiosSuccess: (model) {
        final radios = model.radios ?? [];
        onRadiosLoaded(radios);
        final displayRadios = searchText.isNotEmpty ? searchedRadios : radios;
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          itemCount: displayRadios.length,
          itemBuilder: (context, index) {
            final radio = displayRadios[index];
            return RadioListItem(
              radio: radio,
              isSelected: selectedRadio?.id == radio.id,
              onTap: () => onRadioSelected(radio),
            );
          },
          separatorBuilder: (_, __) => Divider(
            color: Colors.white.withValues(alpha: 0.2),
            indent: 20.w,
            endIndent: 20.w,
          ),
        );
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
  }
}
