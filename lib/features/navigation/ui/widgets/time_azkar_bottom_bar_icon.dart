import 'package:flutter/material.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/core/widgets/salomon_bottom_bar.dart';

SalomonBottomBarItem timeAzkarBottomBarIcon() {
  return SalomonBottomBarItem(
    icon: const Icon(Icons.more_horiz, color: ColorsManager.black),
    title: const Text("المزيد", style: TextStyle(color: Colors.white)),
    selectedColor: ColorsManager.black,
    activeIcon: const Icon(Icons.more_horiz, color: Colors.white),
  );
}
