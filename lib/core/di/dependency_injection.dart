import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:islami_app/core/networking/api_service.dart';
import 'package:islami_app/core/networking/dio_factory.dart';
import 'package:islami_app/features/ahadith/data/repos/ahadith_repo.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_cubit.dart';
import 'package:islami_app/features/home/data/repos/home_repo.dart';
import 'package:islami_app/features/home/logic/cubit/home_cubit.dart';
import 'package:islami_app/features/radios/data/repos/radio_repo.dart';
import 'package:islami_app/features/radios/data/services/radio_api_service.dart';
import 'package:islami_app/features/radios/logic/audio_handler/radio_audio_handler.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_cubit.dart';
import 'package:islami_app/features/surah_details/data/repos/sura_details_repo.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:islami_app/features/surah_details/logic/cubit/sura_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  getIt.registerLazySingleton<HadithApiService>(() => HadithApiService(dio));
  getIt.registerLazySingleton<RadioApiService>(() => RadioApiService(dio));

  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  getIt.registerLazySingleton<SuraDetailsRepo>(() => SuraDetailsRepo(getIt()));
  getIt.registerFactory<SuraDetailsCubit>(() => SuraDetailsCubit(getIt()));

  getIt.registerFactory<AudioCubit>(
    () => AudioCubit(getIt<RadioAudioHandler>()),
  );

  getIt.registerLazySingleton<RadioRepo>(() => RadioRepo(getIt()));
  getIt.registerFactory<RadiosCubit>(() => RadiosCubit(getIt()));
  getIt.registerFactory<RadioCubit>(() => RadioCubit());

  getIt.registerLazySingleton<AhadithRepo>(() => AhadithRepo(getIt()));
  getIt.registerFactory<AhadithCubit>(() => AhadithCubit(getIt()));
}
