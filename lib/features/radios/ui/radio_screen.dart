import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/core/widgets/custom_scaffold.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_cubit.dart';
import 'package:islami_app/features/radios/ui/widgets/radios_list_widget.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<GlobalAudioManager>()),
        BlocProvider(create: (_) => getIt<RadiosCubit>()..getAllRadios()),
        BlocProvider(create: (_) => getIt<RadioCubit>()),
      ],
      child: const CustomScaffold(body: RadiosListWidget()),
    );
  }
}
