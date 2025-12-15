import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/services/location_permission_service.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  Future<void> _enableLocation(BuildContext context) async {
    final result = await LocationPermissionService.requestLocationPermission();

    if (!result.granted && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.message,
            style: const TextStyle(fontFamily: 'Janna-LT'),
          ),
          backgroundColor: ColorsManager.mainGold,
          duration: const Duration(seconds: 3),
        ),
      );
    }
    // لا ننتقل للصفحة التالية - المستخدم يستخدم زر "ابدأ الاستخدام"
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const IslamiLogoAndMosque(),
          verticalSpace(30),
          _buildIcon(context),
          verticalSpace(25),
          Text('تحديد موقعك', style: AppTextStyles.font24GoldBold),
          verticalSpace(15),
          _buildDescription(),
          verticalSpace(30),
          _buildEnableButton(context),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final size = MediaQuery.of(context).size.height * 0.22;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ColorsManager.mainGold.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.location_on,
        size: size * 0.55,
        color: ColorsManager.mainGold,
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'نستخدم موقعك الجغرافي فقط لتحديد مواقيت الصلاة والأذان بدقة حسب مدينتك، ولا يتم حفظ موقعك أو مشاركته مع أي جهة أخرى.',
        style: AppTextStyles.font16WhiteBold,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEnableButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _enableLocation(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.mainGold,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'تفعيل الموقع',
            style: TextStyle(
              color: ColorsManager.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
