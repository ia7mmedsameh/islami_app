import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/features/surah_details/data/repos/sura_details_repo.dart';
import 'package:islami_app/features/surah_details/logic/cubit/sura_details_state.dart';

class SuraDetailsCubit extends Cubit<SuraDetailsState> {
  final SuraDetailsRepo suraDetailsRepo;
  SuraDetailsCubit(this.suraDetailsRepo)
    : super(const SuraDetailsState.initial());

  void getSuraDetailsByNumber(int number) async {
    if (isClosed) return;
    emit(const SuraDetailsState.suraDetailsStateLoading());

    final response = await suraDetailsRepo.getSuraDetailsByNumber(number);
    if (isClosed) return;
    response.when(
      success: (suraDetailsResponseModel) {
        if (!isClosed) {
          emit(
            SuraDetailsState.suraDetailsStateSuccess(suraDetailsResponseModel),
          );
        }
      },
      failure: (apiErrorModel) {
        if (!isClosed) {
          emit(SuraDetailsState.suraDetailsStateError(apiErrorModel));
        }
      },
    );
  }
}
