import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:islami_app/core/networking/api_service.dart';
import 'package:islami_app/core/networking/dio_factory.dart';
import 'package:islami_app/core/audio_handler/audio_handler.dart';
import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/services/adhan_service.dart';
import 'package:islami_app/features/home/data/repos/home_repo.dart';
import 'package:islami_app/features/home/logic/cubit/home_cubit.dart';
import 'package:islami_app/features/ahadith/data/repos/ahadith_repo.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_cubit.dart';
import 'package:islami_app/features/radios/data/repos/radio_repo.dart';
import 'package:islami_app/features/radios/data/services/radio_api_service.dart';
import 'package:islami_app/features/radios/logic/cubit/radio_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_cubit.dart';
import 'package:islami_app/features/surah_details/data/repos/sura_details_repo.dart';
import 'package:islami_app/features/surah_details/logic/cubit/audio_cubit.dart';
import 'package:islami_app/features/surah_details/logic/cubit/sura_details_cubit.dart';
import 'package:islami_app/features/prayer_times/data/services/prayer_times_api_service.dart';
import 'package:islami_app/features/prayer_times/data/api/azkar_api_service.dart';
import 'package:islami_app/features/prayer_times/data/services/azkar_service.dart';
import 'package:islami_app/features/prayer_times/data/repos/prayer_times_repo.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<HadithApiService>(
    () => HadithApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<RadioApiService>(
    () => RadioApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerLazySingleton<SuraDetailsRepo>(() => SuraDetailsRepo(getIt()));
  getIt.registerFactory<SuraDetailsCubit>(() => SuraDetailsCubit(getIt()));
  getIt.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
  getIt.registerLazySingleton<RadioAudioHandler>(
    () => RadioAudioHandler(getIt<AudioPlayer>()),
  );
  getIt.registerFactory<AudioCubit>(
    () => AudioCubit(getIt<RadioAudioHandler>()),
  );
  getIt.registerLazySingleton<GlobalAudioManager>(
    () => GlobalAudioManager(getIt<RadioAudioHandler>()),
  );
  getIt.registerLazySingleton<RadioRepo>(() => RadioRepo(getIt()));
  getIt.registerFactory<RadiosCubit>(() => RadiosCubit(getIt()));
  getIt.registerFactory<RadioCubit>(() => RadioCubit());
  getIt.registerLazySingleton<AhadithRepo>(() => AhadithRepo(getIt()));
  getIt.registerFactory<AhadithCubit>(() => AhadithCubit(getIt()));
  getIt.registerLazySingleton<AdhanService>(() => AdhanService());
  getIt.registerLazySingleton<PrayerTimesApiService>(
    () => PrayerTimesApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<AzkarApiService>(
    () => AzkarApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<AzkarService>(
    () => AzkarService(getIt<AzkarApiService>()),
  );
  getIt.registerLazySingleton<PrayerTimesRepo>(
    () => PrayerTimesRepo(getIt<PrayerTimesApiService>()),
  );
  getIt.registerFactory<PrayerTimesCubit>(
    () => PrayerTimesCubit(getIt<PrayerTimesRepo>(), getIt<AdhanService>()),
  );
}
