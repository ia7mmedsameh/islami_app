import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/extensions.dart';
import 'package:islami_app/core/routing/routes.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';

class PrivacyLinkButton extends StatelessWidget {
  const PrivacyLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        context.pushNamed(Routes.privacyPolicyScreen);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: ColorsManager.gray.withValues(alpha: 0.3)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.privacy_tip_outlined,
              color: ColorsManager.mainGold,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text('سياسة الخصوصية', style: AppTextStyles.font16GoldBold),
          ],
        ),
      ),
    );
  }
}
