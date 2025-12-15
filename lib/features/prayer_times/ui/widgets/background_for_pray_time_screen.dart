
import 'package:flutter/material.dart';
import 'package:islami_app/core/helpers/app_assets.dart';

class Backgroungforpraytimescreen extends StatelessWidget {
  const Backgroungforpraytimescreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesBackgroundPrayTime),
            fit: BoxFit.fitWidth,
               alignment: Alignment.topCenter, 
          ),
        ),
      ),
    );
  }
}
