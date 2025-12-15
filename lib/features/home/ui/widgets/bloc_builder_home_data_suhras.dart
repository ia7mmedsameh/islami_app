import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/app_assets.dart';
import 'package:islami_app/core/helpers/extensions.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/routing/routes.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/widgets/app_text_form_field.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:islami_app/features/home/data/models/surahs_response_model.dart';
import 'package:islami_app/features/home/logic/cubit/home_cubit.dart';
import 'package:islami_app/features/home/logic/cubit/home_state.dart';
import 'package:islami_app/features/home/ui/widgets/surahs_list_body.dart';

class BlocBuilderHomeDataSurahs extends StatefulWidget {
  const BlocBuilderHomeDataSurahs({super.key});
  @override
  State<BlocBuilderHomeDataSurahs> createState() =>
      _BlocBuilderHomeDataSurahsState();
}

class _BlocBuilderHomeDataSurahsState extends State<BlocBuilderHomeDataSurahs> {
  final TextEditingController _searchController = TextEditingController();
  List<SurahsData> allSurahs = [];
  List<SurahsData> searchedSurahs = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String normalizeArabic(String str) {
    str = str.replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), '');
    return str.replaceAll(RegExp(r'[أإآٱ]'), 'ا');
  }

  void _filterSurahs(String query) {
    final q = normalizeArabic(query.toLowerCase());
    setState(() {
      searchedSurahs = allSurahs.where((surah) {
        final nameAr = normalizeArabic(surah.name!.toLowerCase());
        final nameEn = surah.englishName!.toLowerCase();
        return nameAr.contains(q) || nameEn.contains(q);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getAllSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            verticalSpace(15),
            // صف يحتوي على اللوجو وأيقونة الإعدادات
            Row(
              children: [
                const Expanded(child: IslamiLogoAndMosque()),
                IconButton(
                  onPressed: () =>
                      context.pushNamed(Routes.privacyPolicyScreen),
                  icon: Icon(
                    Icons.info_outline,
                    color: ColorsManager.mainGold,
                    size: 28.sp,
                  ),
                  tooltip: 'سياسة الخصوصية',
                ),
              ],
            ),
            verticalSpace(25),
            AppTextField(
              hintText: 'اسم السورة',
              prefixIcon: Assets.svgsQuranIcon,
              controller: _searchController,
              onChanged: _filterSurahs,
            ),
            verticalSpace(25),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) => SurahsListBody(
                  state: state,
                  allSurahs: allSurahs,
                  searchedSurahs: searchedSurahs,
                  searchText: _searchController.text,
                  onSurahsLoaded: (surahs) {
                    if (allSurahs.isEmpty) allSurahs = surahs;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
