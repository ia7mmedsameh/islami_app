import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_cubit.dart';
import 'package:islami_app/features/ahadith/ui/widgets/ahadith_body.dart';

class AhadithScreen extends StatefulWidget {
  const AhadithScreen({super.key});

  @override
  State<AhadithScreen> createState() => _AhadithScreenState();
}

class _AhadithScreenState extends State<AhadithScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return BlocProvider(
      create: (context) => getIt<AhadithCubit>()..getAllHadiths(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: AhadithBody(
          pageController: _pageController,
          currentPage: _currentPage,
        ),
      ),
    );
  }
}
