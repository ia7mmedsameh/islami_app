import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/widgets/salomon_bottom_bar.dart';

class SalomonBottomBarItemWidget extends StatelessWidget {
  final SalomonBottomBarItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? selectedColorOpacity;
  final ShapeBorder itemShape;
  final EdgeInsets scaledPadding;
  final Duration duration;
  final Curve curve;

  const SalomonBottomBarItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    required this.itemShape,
    required this.scaledPadding,
    required this.duration,
    required this.curve,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor =
        item.selectedColor ?? selectedItemColor ?? theme.primaryColor;
    final unselectedColor =
        item.unselectedColor ?? unselectedItemColor ?? theme.iconTheme.color;

    return TweenAnimationBuilder<double>(
      tween: Tween(end: isSelected ? 1.0 : 0.0),
      curve: curve,
      duration: duration,
      builder: (context, t, _) => Material(
        color: Color.lerp(
          selectedColor.withValues(alpha: 0.0),
          selectedColor.withValues(alpha: selectedColorOpacity ?? 0.5),
          t,
        ),
        shape: itemShape,
        child: InkWell(
          onTap: onTap,
          customBorder: itemShape,
          focusColor: selectedColor.withValues(alpha: 0.1),
          highlightColor: selectedColor.withValues(alpha: 0.1),
          splashColor: selectedColor.withValues(alpha: 0.1),
          hoverColor: selectedColor.withValues(alpha: 0.1),
          child: Padding(
            padding:
                scaledPadding -
                (Directionality.of(context) == TextDirection.ltr
                    ? EdgeInsets.only(right: scaledPadding.right * t)
                    : EdgeInsets.only(left: scaledPadding.left * t)),
            child: Row(
              children: [
                IconTheme(
                  data: IconThemeData(
                    color: Color.lerp(unselectedColor, selectedColor, t),
                    size: 24.sp,
                  ),
                  child: isSelected ? item.activeIcon ?? item.icon : item.icon,
                ),
                ClipRect(
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 25.h,
                    child: Align(
                      alignment: const Alignment(-0.2, 0.0),
                      widthFactor: t,
                      child: Padding(
                        padding: Directionality.of(context) == TextDirection.ltr
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
                            fontSize: 16.sp,
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
      ),
    );
  }
}
