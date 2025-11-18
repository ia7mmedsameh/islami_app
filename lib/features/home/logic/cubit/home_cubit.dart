import 'package:bloc/bloc.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/features/home/data/repos/home_repo.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(const HomeState.initial());

  void getAllSurahs() async {
    if (isClosed) return;
    
    // محاولة جلب البيانات المحلية أولاً (بدون loading)
    final cachedResponse = homeRepo.getCachedSurahs();
    if (cachedResponse != null) {
      cachedResponse.when(
        success: (surahsResponseModel) {
          if (!isClosed) {
            // إذا وُجدت بيانات محلية، نعرضها مباشرة
            emit(HomeState.surahsSuccess(surahsResponseModel));
          }
        },
        failure: (_) {
          // إذا فشل parsing البيانات المحلية، نجلب من API
          if (!isClosed) {
            emit(const HomeState.surahsLoading());
            _fetchFromApi();
          }
        },
      );
      return;
    }
    
    // إذا لم توجد بيانات محلية، نعرض loading ثم نجلب من API
    if (!isClosed) {
      emit(const HomeState.surahsLoading());
      _fetchFromApi();
    }
  }

  Future<void> _fetchFromApi() async {
    if (isClosed) return;
    final response = await homeRepo.getAllSurahs(forceRefresh: true);
    if (isClosed) return;
    response.when(
      success: (surahsResponseModel) {
        if (!isClosed) {
          emit(HomeState.surahsSuccess(surahsResponseModel));
        }
      },
      failure: (apiErrorModel) {
        if (!isClosed) {
          emit(HomeState.surahsError(apiErrorModel));
        }
      },
    );
  }
}
