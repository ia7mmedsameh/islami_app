import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/theming/colors.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_cubit.dart';
import 'package:islami_app/features/radios/ui/widgets/radios_list_widget.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<RadiosCubit>()..getAllRadios()),
        BlocProvider(create: (_) => getIt<RadioCubit>()),
      ],
      child: Scaffold(
        backgroundColor: ColorsManager.black,
        appBar: AppBar(
          backgroundColor: ColorsManager.black,
          foregroundColor: Colors.white,
          title: const Text("الراديو"),
        ),
        body: const RadiosListWidget(),
      ),
    );
  }
}
