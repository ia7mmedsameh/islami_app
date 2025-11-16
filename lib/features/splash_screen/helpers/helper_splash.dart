import 'package:flutter/material.dart';

class SplashAnimations {
  late final AnimationController mosqueCtrl;
  late final Animation<double> mosqueOpacity;

  late final AnimationController logoIntroCtrl;
  late final Animation<double> logoIntroScale;
  late final AnimationController logoPulseCtrl;
  late final Animation<double> logoPulseScale;

  late final AnimationController nameCtrl;
  late final Animation<Offset> nameOffset;

  late final AnimationController glowCtrl;
  late final Animation<Offset> glowOffset;
  late final Animation<double> glowOpacity;

  late final AnimationController leftShapeCtrl;
  late final Animation<Offset> leftShapeOffset;
  late final AnimationController rightShapeCtrl;
  late final Animation<Offset> rightShapeOffset;

  late final AnimationController screenFadeCtrl;
  late final Animation<double> screenFade;

  SplashAnimations(TickerProvider vsync) {
    _initMosque(vsync);
    _initLogo(vsync);
    _initName(vsync);
    _initGlow(vsync);
    _initShapes(vsync);
    _initScreenFade(vsync);
  }

  void _initMosque(TickerProvider vsync) {
    mosqueCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 3),
    );
    mosqueOpacity = CurvedAnimation(
      parent: mosqueCtrl,
      curve: Curves.easeInOutCubic,
    );
  }

  void _initLogo(TickerProvider vsync) {
    logoIntroCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1600),
    );
    logoIntroScale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: logoIntroCtrl, curve: Curves.easeOutBack),
    );

    logoPulseCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2800),
    );
    logoPulseScale = Tween(begin: 0.98, end: 1.03).animate(
      CurvedAnimation(parent: logoPulseCtrl, curve: Curves.easeInOut),
    );
  }

  void _initName(TickerProvider vsync) {
    nameCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1800),
    );
    nameOffset = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, 2.0), end: const Offset(0, -0.2))
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, -0.2), end: const Offset(0, 0.1))
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, 0.1), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
    ]).animate(nameCtrl);
  }

  void _initGlow(TickerProvider vsync) {
    glowCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2200),
    );
    glowOffset = Tween(begin: const Offset(0, -0.4), end: Offset.zero).animate(
      CurvedAnimation(parent: glowCtrl, curve: Curves.easeInOutCubic),
    );
    glowOpacity = CurvedAnimation(parent: glowCtrl, curve: Curves.easeInOut);
  }

  void _initShapes(TickerProvider vsync) {
    leftShapeCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2500),
    );
    leftShapeOffset = Tween(begin: const Offset(-0.6, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: leftShapeCtrl, curve: Curves.easeInOutCubic));

    rightShapeCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1800),
    );
    rightShapeOffset = Tween(begin: const Offset(0.6, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: rightShapeCtrl, curve: Curves.easeInOutCubic));
  }

  void _initScreenFade(TickerProvider vsync) {
    screenFadeCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    );
    screenFade = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: screenFadeCtrl, curve: Curves.easeInOut),
    );
  }

  void dispose() {
    mosqueCtrl.dispose();
    logoIntroCtrl.dispose();
    logoPulseCtrl.dispose();
    nameCtrl.dispose();
    glowCtrl.dispose();
    leftShapeCtrl.dispose();
    rightShapeCtrl.dispose();
    screenFadeCtrl.dispose();
  }
}
