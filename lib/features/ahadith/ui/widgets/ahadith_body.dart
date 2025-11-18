import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:islami_app/core/widgets/setup_error.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_cubit.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_state.dart';
import 'package:islami_app/features/ahadith/ui/widgets/backgroung_for_ahadith_screen.dart';
import 'package:islami_app/features/ahadith/ui/widgets/color_linear_for_ahadith_screen.dart';
import 'package:islami_app/features/ahadith/ui/widgets/content_card_ahadith.dart';

class AhadithBody extends StatelessWidget {
  const AhadithBody({
    super.key,
    required this.pageController,
    required this.currentPage,
  });

  final PageController pageController;
  final double currentPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroungForAhadithScreen(),
        const ColorLinearForAhadithScreen(),
        SafeArea(
          child: Column(
            children: [
              verticalSpace(15),
              const IslamiLogoAndMosque(),
              Expanded(
                child: BlocBuilder<AhadithCubit, AhadithState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      ahadithLoading: () =>
                          const Center(child: CircularProgressIndicator()),
                      ahadithError: (error) => setupError(error),
                      ahadithSuccess: (ahadithResponseModel) {
                        final hadithList =
                            ahadithResponseModel.hadiths?.data ?? [];
                        if (hadithList.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا توجد أحاديث متاحة',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        return PageView.builder(
                          controller: pageController,
                          itemCount: hadithList.length,
                          itemBuilder: (context, index) {
                            double distance = (currentPage - index).abs();
                            double scale = 1 - (distance * 0.1);
                            if (scale < 0.9) scale = 0.9;
                            return TweenAnimationBuilder<double>(
                              tween: Tween(begin: scale, end: scale),
                              duration: const Duration(milliseconds: 250),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: ContentCardAhadith(
                                    index: index,
                                    data: hadithList[index],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
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
