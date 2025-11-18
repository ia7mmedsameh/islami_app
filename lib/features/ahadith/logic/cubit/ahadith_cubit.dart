import 'package:bloc/bloc.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/features/ahadith/data/repos/ahadith_repo.dart';

import 'ahadith_state.dart';

class AhadithCubit extends Cubit<AhadithState> {
  final AhadithRepo ahadithRepo;
  AhadithCubit(this.ahadithRepo) : super(const AhadithState.initial());

  void getAllHadiths() async {
    if (isClosed) return;
    
    // محاولة جلب البيانات المحلية أولاً (بدون loading)
    final cachedResponse = ahadithRepo.getCachedAhadith();
    if (cachedResponse != null) {
      cachedResponse.when(
        success: (ahadithResponseModel) {
          if (!isClosed) {
            // إذا وُجدت بيانات محلية، نعرضها مباشرة
            emit(AhadithState.ahadithSuccess(ahadithResponseModel));
          }
        },
        failure: (_) {
          // إذا فشل parsing البيانات المحلية، نجلب من API
          if (!isClosed) {
            emit(const AhadithState.ahadithLoading());
            _fetchFromApi();
          }
        },
      );
      return;
    }
    
    // إذا لم توجد بيانات محلية، نعرض loading ثم نجلب من API
    if (!isClosed) {
      emit(const AhadithState.ahadithLoading());
      _fetchFromApi();
    }
  }

  Future<void> _fetchFromApi() async {
    if (isClosed) return;
    final response = await ahadithRepo.getAllHadiths(forceRefresh: true);
    if (isClosed) return;
    response.when(
      success: (ahadithResponseModel) {
        if (!isClosed) {
          emit(AhadithState.ahadithSuccess(ahadithResponseModel));
        }
      },
      failure: (apiErrorModel) {
        if (!isClosed) {
          emit(AhadithState.ahadithError(apiErrorModel));
        }
      },
    );
  }
}
