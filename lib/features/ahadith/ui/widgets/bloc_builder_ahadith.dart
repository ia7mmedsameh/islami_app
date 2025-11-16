import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/widgets/setup_error.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_cubit.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_state.dart';
import 'package:islami_app/features/ahadith/ui/widgets/details_ahadith.dart';

class BlocBuilderAhadith extends StatelessWidget {
  const BlocBuilderAhadith({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AhadithCubit, AhadithState>(
      builder: (context, state) {
        return state.maybeWhen(
          ahadithLoading: () => setupLoading(),
          ahadithError: (error) => setupError(error),
          ahadithSuccess: (ahadithResponseModel) {
            final hadithList =
                ahadithResponseModel.hadiths?.data ?? [];
    
            final hadith = hadithList[index % hadithList.length];
    
            return DetailsAhadith(hadith: hadith);
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
