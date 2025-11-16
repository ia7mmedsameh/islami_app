import 'package:flutter/material.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';
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
                child: PageView.builder(
                  controller: pageController,
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
                          child: ContentCardAhadith(index: index, data: Data(),),
                        );
                      },
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
