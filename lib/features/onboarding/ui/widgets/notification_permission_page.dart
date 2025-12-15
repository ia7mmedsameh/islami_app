import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/core/helpers/spacing.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/theming/styles.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionPage extends StatelessWidget {
  const NotificationPermissionPage({super.key});

  Future<void> _enableNotifications(BuildContext context) async {
    final status = await Permission.notification.request();
    final box = await Hive.openBox('app_settings');

    if (status.isGranted) {
      // تفعيل الأذكار (تعتمد على الإشعارات)
      await box.put('azkar_reminder_enabled', true);
    } else {
      // إيقاف الأذكار لأن الإشعارات مرفوضة
      await box.put('azkar_reminder_enabled', false);
    }
    // الأذان والصلاة على النبي يعملوا بالصوت (Alarm) بدون إشعارات
    // لا ننتقل للصفحة التالية - المستخدم يستخدم زر "التالي"
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
          Text('الإشعارات', style: AppTextStyles.font24GoldBold),
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
        Icons.notifications_active,
        size: size * 0.55,
        color: ColorsManager.mainGold,
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'نستخدم الإشعارات لتذكيرك بالأذكار والتذكير بالصلاة على النبي ﷺ، ويمكنك التحكم في هذه التنبيهات أو إيقافها في أي وقت من الإعدادات.',
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
          onPressed: () => _enableNotifications(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.mainGold,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'تفعيل الإشعارات',
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
