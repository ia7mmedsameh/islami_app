import 'package:bloc/bloc.dart';
import 'package:islami_app/core/networking/api_result.dart';
import 'package:islami_app/features/radios/data/repos/radio_repo.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_state.dart';

class RadiosCubit extends Cubit<RadiosState> {
  final RadioRepo radioRepo;
  RadiosCubit(this.radioRepo) : super(const RadiosState.initial());

  void getAllRadios() async {
    if (isClosed) return;
    emit(const RadiosState.radiosLoading());
    final response = await radioRepo.getAllRadios();
    if (isClosed) return;
    response.when(
      success: (radioResponseModel) {
        if (!isClosed) {
          emit(RadiosState.radiosSuccess(radioResponseModel));
        }
      },
      failure: (apiErrorModel) {
        if (!isClosed) {
          emit(
            RadiosState.radiosError(
              apiErrorModel.status ?? apiErrorModel.data ?? 'حدث خطأ',
            ),
          );
        }
      },
    );
  }
}
