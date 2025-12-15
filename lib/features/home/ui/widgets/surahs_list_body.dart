import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/widgets/setup_error.dart';
import 'package:islami_app/features/home/data/models/surahs_response_model.dart';
import 'package:islami_app/features/home/logic/cubit/home_state.dart';
import 'package:islami_app/features/home/ui/widgets/quran_list_text_and_list_view_builder.dart';
import 'package:islami_app/features/home/ui/widgets/surahs_shimmer_loading.dart';

class SurahsListBody extends StatelessWidget {
  final HomeState state;
  final List<SurahsData> allSurahs;
  final List<SurahsData> searchedSurahs;
  final String searchText;
  final Function(List<SurahsData>) onSurahsLoaded;

  const SurahsListBody({
    super.key,
    required this.state,
    required this.allSurahs,
    required this.searchedSurahs,
    required this.searchText,
    required this.onSurahsLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return state.maybeWhen(
      surahsLoading: () => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 200.h,
          child: const SurahsShimmerLoading(),
        ),
      ),
      surahsSuccess: (surahsResponseModel) {
        final surahs = surahsResponseModel.data ?? [];
        onSurahsLoaded(surahs);
        final displayList = searchText.isNotEmpty ? searchedSurahs : surahs;
        return QuranListTextAndListViewBuilder(surahsList: displayList);
      },
      surahsError: (apiErrorModel) => setupError(apiErrorModel),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
