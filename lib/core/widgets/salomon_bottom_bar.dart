import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final theme = Theme.of(context);

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
              TweenAnimationBuilder<double>(
                tween: Tween(
                  end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
                ),
                curve: curve,
                duration: duration,
                builder: (context, t, _) {
                  final selectedColor =
                      item.selectedColor ?? selectedItemColor ?? theme.primaryColor;
                  final unselectedColor =
                      item.unselectedColor ?? unselectedItemColor ?? theme.iconTheme.color;

                  return Material(
                    color: Color.lerp(
                      selectedColor.withValues(alpha: 0.0),
                      selectedColor.withValues(alpha: selectedColorOpacity ?? 0.5),
                      t,
                    ),
                    shape: itemShape,
                    child: InkWell(
                      onTap: () => onTap?.call(items.indexOf(item)),
                      customBorder: itemShape,
                      focusColor: selectedColor.withValues(alpha: 0.1),
                      highlightColor: selectedColor.withValues(alpha: 0.1),
                      splashColor: selectedColor.withValues(alpha: 0.1),
                      hoverColor: selectedColor.withValues(alpha: 0.1),
                      child: Padding(
                        padding: scaledPadding -
                            (Directionality.of(context) == TextDirection.ltr
                                ? EdgeInsets.only(right: scaledPadding.right * t)
                                : EdgeInsets.only(left: scaledPadding.left * t)),
                        child: Row(
                          children: [
                            IconTheme(
                              data: IconThemeData(
                                color: Color.lerp(unselectedColor, selectedColor, t),
                                size: 24.sp, // responsive icon size
                              ),
                              child: items.indexOf(item) == currentIndex
                                  ? item.activeIcon ?? item.icon
                                  : item.icon,
                            ),
                            ClipRect(
                              clipBehavior: Clip.antiAlias,
                              child: SizedBox(
                                height: 25.h,
                                child: Align(
                                  alignment: const Alignment(-0.2, 0.0),
                                  widthFactor: t,
                                  child: Padding(
                                    padding: Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? EdgeInsets.only(
                                            left: scaledPadding.left / 2,
                                            right: scaledPadding.right,
                                          )
                                        : EdgeInsets.only(
                                            left: scaledPadding.left,
                                            right: scaledPadding.right / 2,
                                          ),
                                    child: DefaultTextStyle.merge(
                                      style: TextStyle(
                                        fontSize: 16.sp, // responsive text
                                        fontWeight: FontWeight.w600,
                                        height: 1.2,
                                        color: Color.lerp(
                                          selectedColor.withValues(alpha: 0.0),
                                          selectedColor,
                                          t,
                                        ),
                                      ),
                                      child: item.title,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
