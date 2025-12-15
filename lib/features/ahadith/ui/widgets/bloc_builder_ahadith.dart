import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/widgets/setup_error.dart';
import 'package:islami_app/features/ahadith/data/models/ahadith_response_model.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_cubit.dart';
import 'package:islami_app/features/ahadith/logic/cubit/ahadith_state.dart';
import 'package:islami_app/features/ahadith/ui/widgets/details_ahadith.dart';

class BlocBuilderAhadith extends StatefulWidget {
  const BlocBuilderAhadith({
    super.key,
    required this.index,
    this.onHadithReady,
  });

  final int index;
  final ValueChanged<Data>? onHadithReady;

  @override
  State<BlocBuilderAhadith> createState() => _BlocBuilderAhadithState();
}

class _BlocBuilderAhadithState extends State<BlocBuilderAhadith> {
  Data? _lastHadith;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AhadithCubit, AhadithState>(
      builder: (context, state) {
        return state.maybeWhen(
          ahadithLoading: () => setupLoading(),
          ahadithError: (error) => setupError(error),
          ahadithSuccess: (ahadithResponseModel) {
            final hadithList = ahadithResponseModel.hadiths?.data ?? [];

            final hadith = hadithList[widget.index % hadithList.length];

            if (hadith.id != _lastHadith?.id && widget.onHadithReady != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  _lastHadith = hadith;
                  widget.onHadithReady?.call(hadith);
                }
              });
            }

            return DetailsAhadith(hadith: hadith);
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
