import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/features/home/data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(const HomeState.initial());

  void getAllSurahs() async {
    if (isClosed) return;
    final cachedResponse = homeRepo.getCachedSurahs();
    if (cachedResponse != null) {
      if (cachedResponse is Success) {
        if (!isClosed) {
          emit(HomeState.surahsSuccess((cachedResponse as Success).data));
          _saveSurahNamesToStorage((cachedResponse as Success).data.data);
        }
      } else {
        if (!isClosed) {
          emit(const HomeState.surahsLoading());
          _fetchFromApi();
        }
      }
      return;
    }
    if (!isClosed) {
      emit(const HomeState.surahsLoading());
      _fetchFromApi();
    }
  }

  Future<void> _fetchFromApi() async {
    if (isClosed) return;
    final response = await homeRepo.getAllSurahs(forceRefresh: true);
    if (isClosed) return;
    if (response is Success) {
      if (!isClosed) {
        emit(HomeState.surahsSuccess((response as Success).data));
        _saveSurahNamesToStorage((response as Success).data.data);
      }
    } else if (response is Failure) {
      if (!isClosed) {
        emit(HomeState.surahsError((response as Failure).apiErrorModel));
      }
    }
  }

  Future<void> _saveSurahNamesToStorage(List<dynamic>? surahs) async {
    if (surahs == null || surahs.isEmpty) return;
    try {
      final box = await Hive.openBox('app_settings');
      final Map<String, String> surahNames = {};
      for (final surah in surahs) {
        if (surah.number != null && surah.name != null) {
          surahNames[surah.number.toString()] = surah.name;
        }
      }
      await box.put('surah_names_map', surahNames);
    } catch (_) {}
  }
}
