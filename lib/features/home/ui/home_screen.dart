import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/features/home/logic/cubit/home_cubit.dart';
import 'package:islami_app/features/home/ui/widgets/background_for_home_page.dart';
import 'package:islami_app/features/home/ui/widgets/bloc_builder_home_data_suhras.dart';
import 'package:islami_app/features/home/ui/widgets/color_linear_for_home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );

    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: const Stack(
        children: [
          BackgroundForHomePage(),
          ColorLinearForHomePage(),
          BlocBuilderHomeDataSurahs(),
        ],
      ),
    );
  }
}
