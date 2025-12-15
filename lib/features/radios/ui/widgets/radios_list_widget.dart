import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:islami_app/core/audio_manager/global_audio_manager.dart';
import 'package:islami_app/core/audio_manager/global_audio_state.dart';
import 'package:islami_app/core/di/dependency_injection.dart';
import 'package:islami_app/features/home/ui/widgets/color_linear_for_home_page.dart';
import 'package:islami_app/features/radios/data/models/radio_response_model.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_cubit.dart';
import 'package:islami_app/features/radios/logic/cubit/radios_state.dart';
import 'package:islami_app/features/radios/ui/widgets/back_ground_for_radios_screen.dart';
import 'package:islami_app/features/radios/ui/widgets/radio_player_container.dart';
import 'package:islami_app/features/radios/ui/widgets/radios_list_body.dart';
import 'package:islami_app/features/radios/ui/widgets/radios_list_header.dart';

class RadiosListWidget extends StatefulWidget {
  const RadiosListWidget({super.key});
  @override
  State<RadiosListWidget> createState() => _RadiosListWidgetState();
}

class _RadiosListWidgetState extends State<RadiosListWidget> {
  final _searchController = TextEditingController();
  List<RadioData> allRadios = [];
  List<RadioData> searchedRadios = [];
  RadioData? selectedRadio;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRadios(String query) {
    final q = _normalize(query.toLowerCase());
    setState(
      () => searchedRadios = allRadios
          .where((r) => _normalize(r.name?.toLowerCase() ?? '').contains(q))
          .toList(),
    );
  }

  String _normalize(String s) => s
      .replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), '')
      .replaceAll(RegExp(r'[أإآٱ]'), 'ا');

  void _onRadioSelected(RadioData radio) async {
    final box = await Hive.openBox('app_settings');
    await box.put('selected_radio_id', radio.id);
    setState(() => selectedRadio = radio);
  }

  void _onRadiosLoaded(List<RadioData> radios) async {
    if (allRadios.isNotEmpty) return;
    allRadios = radios;
    final globalState = getIt<GlobalAudioManager>().state;
    if (globalState is PlayingQuran) return;
    final box = await Hive.openBox('app_settings');
    final savedId = box.get('selected_radio_id');
    if (savedId == null || !mounted) return;
    final radio = radios.cast<RadioData?>().firstWhere(
      (r) => r?.id == savedId,
      orElse: () => null,
    );
    if (radio != null && mounted) setState(() => selectedRadio = radio);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalAudioManager, GlobalAudioState>(
      listener: (_, state) {
        if (state is! PlayingRadio || allRadios.isEmpty) return;
        final radio = allRadios.cast<RadioData?>().firstWhere(
          (r) => r?.url == state.radioUrl,
          orElse: () => null,
        );
        if (radio != null && radio.id != selectedRadio?.id) {
          setState(() => selectedRadio = radio);
        }
      },
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        const BackGroundForRadiosScreen(),
        const ColorLinearForHomePage(),
        SafeArea(
          child: Column(
            children: [
              RadiosListHeader(
                searchController: _searchController,
                onChanged: _filterRadios,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: BlocBuilder<RadiosCubit, RadiosState>(
                    builder: (_, state) => RadiosListBody(
                      state: state,
                      allRadios: allRadios,
                      searchedRadios: searchedRadios,
                      searchText: _searchController.text,
                      onRadiosLoaded: _onRadiosLoaded,
                      onRadioSelected: _onRadioSelected,
                      selectedRadio: selectedRadio,
                    ),
                  ),
                ),
              ),
              if (selectedRadio != null)
                RadioPlayerContainer(
                  key: ValueKey(selectedRadio!.id),
                  radioUrl: selectedRadio!.url ?? '',
                  radioName: selectedRadio!.name ?? '',
                  radios: allRadios,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
