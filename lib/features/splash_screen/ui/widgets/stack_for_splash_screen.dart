
import 'package:flutter/material.dart';
import 'package:islami_app/features/splash_screen/ui/widgets/background_splash.dart';
import 'package:islami_app/features/splash_screen/ui/widgets/bottom_name_ahmed_sameh_splash.dart';
import 'package:islami_app/features/splash_screen/ui/widgets/center_logo_splash.dart';
import 'package:islami_app/features/splash_screen/ui/widgets/glow_splash.dart';
import 'package:islami_app/features/splash_screen/ui/widgets/left_shape_splash.dart';
import 'package:islami_app/features/splash_screen/ui/widgets/mosque_splash.dart';
import 'package:islami_app/features/splash_screen/ui/widgets/right_shape_splash.dart';

class StackForSplashScreen extends StatelessWidget {
  const StackForSplashScreen({
    super.key,
    required Animation<double> mosqueOpacity,
    required Animation<double> glowOpacity,
    required Animation<Offset> glowOffset,
    required this.screenH,
    required Animation<Offset> leftShapeOffset,
    required Animation<Offset> rightShapeOffset,
    required Animation<double> logoIntroScale,
    required Animation<double> logoPulseScale,
    required Animation<Offset> nameOffset,
    required AnimationController nameCtrl,
  }) : _mosqueOpacity = mosqueOpacity, _glowOpacity = glowOpacity, _glowOffset = glowOffset, _leftShapeOffset = leftShapeOffset, _rightShapeOffset = rightShapeOffset, _logoIntroScale = logoIntroScale, _logoPulseScale = logoPulseScale, _nameOffset = nameOffset, _nameCtrl = nameCtrl;

  final Animation<double> _mosqueOpacity;
  final Animation<double> _glowOpacity;
  final Animation<Offset> _glowOffset;
  final double screenH;
  final Animation<Offset> _leftShapeOffset;
  final Animation<Offset> _rightShapeOffset;
  final Animation<double> _logoIntroScale;
  final Animation<double> _logoPulseScale;
  final Animation<Offset> _nameOffset;
  final AnimationController _nameCtrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackGroundSplash(),
    
        MosqueSplash(mosqueOpacity: _mosqueOpacity),
    
        GlowSplash(glowOpacity: _glowOpacity, glowOffset: _glowOffset),
    
        LeftShapeSplash(
          screenH: screenH,
          leftShapeOffset: _leftShapeOffset,
        ),
    
        RightShapeSplash(
          screenH: screenH,
          rightShapeOffset: _rightShapeOffset,
        ),
    
        CenterLogoSplash(
          logoIntroScale: _logoIntroScale,
          logoPulseScale: _logoPulseScale,
        ),
    
        BottomNameAhmedSamehSplash(
          nameOffset: _nameOffset,
          nameCtrl: _nameCtrl,
        ),
      ],
    );
  }
}
