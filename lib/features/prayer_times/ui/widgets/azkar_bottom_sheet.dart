import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/prayer_times/data/models/azkar_model.dart';
import 'package:islami_app/features/prayer_times/data/services/azkar_service.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/zikr_card.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/azkar/azkar_sheet_header.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/azkar/azkar_loading.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/azkar/azkar_error.dart';
import 'package:islami_app/features/prayer_times/ui/widgets/azkar/azkar_empty.dart';

class AzkarBottomSheet extends StatelessWidget {
  final AzkarCategory category;

  const AzkarBottomSheet({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: ColorsManager.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          AzkarSheetHeader(
            title: category.nameAr,
            onClose: () => Navigator.pop(context),
          ),
          Expanded(child: _buildContent(context)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return FutureBuilder<List<ZikrItem>>(
      future: getIt<AzkarService>().getAzkar(category.apiKey),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AzkarLoading();
        }
        if (snapshot.hasError) {
          return AzkarError(
            errorMessage: snapshot.error
                .toString()
                .replaceAll('Exception: ', '')
                .replaceAll('Exception', ''),
            onClose: () => Navigator.pop(context),
          );
        }
        if (snapshot.data?.isEmpty ?? true) return const AzkarEmpty();
        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) =>
              ZikrCard(zikr: snapshot.data![index]),
        );
      },
    );
  }
}
