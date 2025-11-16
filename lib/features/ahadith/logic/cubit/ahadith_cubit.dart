import 'package:bloc/bloc.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/features/ahadith/data/repos/ahadith_repo.dart';

import 'ahadith_state.dart';

class AhadithCubit extends Cubit<AhadithState> {
  final AhadithRepo ahadithRepo;
  AhadithCubit(this.ahadithRepo) : super(const AhadithState.initial());

  void getAllHadiths() async {
    if (isClosed) return;
    emit(const AhadithState.ahadithLoading());
    final response = await ahadithRepo.getAllHadiths();
    if (isClosed) return;
    response.when(
      success: (surahsResponseModel) {
        if (!isClosed) {
          emit(AhadithState.ahadithSuccess(surahsResponseModel));
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
