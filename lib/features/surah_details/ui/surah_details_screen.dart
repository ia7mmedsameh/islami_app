import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/widgets/setup_error.dart';
import 'package:islami_app/features/surah_details/logic/cubit/sura_details_cubit.dart';
import 'package:islami_app/features/surah_details/logic/cubit/sura_details_state.dart';
import 'package:islami_app/features/surah_details/ui/widgets/surah_details_item.dart';
import 'package:lottie/lottie.dart';

class SurahDetailsScreen extends StatelessWidget {
  final int surahNumber;

  const SurahDetailsScreen({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SuraDetailsCubit>()..getSuraDetailsByNumber(surahNumber),
      child: BlocBuilder<SuraDetailsCubit, SuraDetailsState>(
        builder: (context, state) {
          return state.maybeWhen(
            suraDetailsStateError: (apiErrorModel) {
              return Scaffold(body: setupError(apiErrorModel));
            },
            suraDetailsStateLoading: () {
              return setupLoading();
            },
            suraDetailsStateSuccess: (suraDetailsResponseModel) {
              final detailsSura = suraDetailsResponseModel.data;
              return SurahDetailsItem(detailsSura: detailsSura!);
            },
            orElse: () {
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}

Widget setupLoading() {
  return Container(
    color: ColorsManager.black,
    width: double.infinity,
    height: double.infinity,
    child: Center(
      child: Lottie.asset(
        Assets.gifsTrailLoading,
        fit: BoxFit.contain,
        repeat: true,
        width: 170.w,
        height: 170.h,
      ),
    ),
  );
}
