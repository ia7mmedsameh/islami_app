import 'package:flutter/material.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/widgets/salomon_bottom_bar.dart';
import 'package:islami_app/features/ahadith/ui/ahadith_screen.dart';
import 'package:islami_app/features/home/ui/home_screen.dart';
import 'package:islami_app/features/navigation/ui/widgets/hadith_bottom_bar_icon.dart';
import 'package:islami_app/features/navigation/ui/widgets/quran_bottom_bar_icon.dart';
import 'package:islami_app/features/navigation/ui/widgets/radio_bottom_bar_icon.dart';
import 'package:islami_app/features/navigation/ui/widgets/sebha_bottom_bar_icon.dart';
import 'package:islami_app/features/navigation/ui/widgets/time_azkar_bottom_bar_icon.dart';
import 'package:islami_app/features/radios/ui/radio_screen.dart';
import 'package:islami_app/features/sebha/ui/sebha_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AhadithScreen(),
    const SebhaScreen(),
    const RadioScreen(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: ColorsManager.mainGold,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          quranBottomBarIcon(),
          hadithBottomBarIcon(),
          sebhaBottomBarIcon(),
          radioBottomBarIcon(),
          timeAzkarBottomBarIcon(),
        ],
      ),
    );
  }
}
