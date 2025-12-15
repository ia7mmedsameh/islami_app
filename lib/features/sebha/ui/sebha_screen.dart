import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/widgets/islami_logo_and_mosque.dart';
import 'package:islami_app/features/sebha/ui/widgets/background_for_sebha_screen.dart';
import 'package:islami_app/features/sebha/ui/widgets/color_linear_for_sebha_screen.dart';
import 'package:islami_app/features/sebha/ui/widgets/sebha_header_text.dart';
import 'package:islami_app/features/sebha/ui/widgets/sebha_reset_button.dart';
import 'package:islami_app/features/sebha/ui/widgets/sebha_rosary_widget.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int _counter = 0;

  void _incrementCounter() {
    HapticFeedback.lightImpact();
    setState(() => _counter++);
  }

  void _resetCounter() {
    setState(() => _counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );

    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: Stack(
        children: [
          const BackgroundForSebhaScreen(),
          const ColorLinearForSebhaScreen(),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                const IslamiLogoAndMosque(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        const SebhaHeaderText(),
                        SizedBox(height: 30.h),
                        SebhaRosaryWidget(
                          counter: _counter,
                          onTap: _incrementCounter,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                SebhaResetButton(onPressed: _resetCounter),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
