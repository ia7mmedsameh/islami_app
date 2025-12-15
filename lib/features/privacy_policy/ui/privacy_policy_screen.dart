import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/core/widgets/custom_scaffold.dart';
import 'package:islami_app/features/privacy_policy/ui/widgets/privacy_section_card.dart';
import 'package:islami_app/features/privacy_policy/ui/widgets/privacy_sections_data.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: ColorsManager.black,
        title: Text('سياسة الخصوصية', style: AppTextStyles.font20GoldBold),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorsManager.mainGold),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('سياسة الخصوصية', style: AppTextStyles.font24GoldBold),
              SizedBox(height: 24.h),
              ...PrivacySectionsData.privacySections.map(_buildSection),
              SizedBox(height: 24.h),
              Text('مصادر المحتوى', style: AppTextStyles.font24GoldBold),
              SizedBox(height: 16.h),
              ...PrivacySectionsData.sourceSections.map(_buildSection),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> data) {
    return PrivacySectionCard(
      icon: data['icon'] as IconData,
      title: data['title'] as String,
      content: data['content'] as String,
    );
  }
}
