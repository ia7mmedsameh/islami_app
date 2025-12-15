import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/core/theming/colors.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );

    return Scaffold(
      backgroundColor: ColorsManager.black,
      resizeToAvoidBottomInset: false,
      body: body,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
