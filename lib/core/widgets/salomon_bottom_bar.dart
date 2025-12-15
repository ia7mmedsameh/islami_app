import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/widgets/salomon_bottom_bar_item_widget.dart';

class SalomonBottomBar extends StatelessWidget {
  const SalomonBottomBar({
    super.key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  });

  final List<SalomonBottomBarItem> items;
  final int currentIndex;
  final Function(int)? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? selectedColorOpacity;
  final ShapeBorder itemShape;
  final EdgeInsets margin;
  final EdgeInsets itemPadding;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final scaledPadding = EdgeInsets.symmetric(
      vertical: itemPadding.vertical.h,
      horizontal: itemPadding.horizontal.w,
    );
    return ColoredBox(
      color: backgroundColor ?? Colors.transparent,
      child: SafeArea(
        minimum: margin,
        child: Row(
          mainAxisAlignment: items.length <= 2
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              SalomonBottomBarItemWidget(
                item: item,
                isSelected: items.indexOf(item) == currentIndex,
                onTap: () => onTap?.call(items.indexOf(item)),
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unselectedItemColor,
                selectedColorOpacity: selectedColorOpacity,
                itemShape: itemShape,
                scaledPadding: scaledPadding,
                duration: duration,
                curve: curve,
              ),
          ],
        ),
      ),
    );
  }
}

class SalomonBottomBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final Widget title;
  final Color? selectedColor;
  final Color? unselectedColor;

  const SalomonBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}
