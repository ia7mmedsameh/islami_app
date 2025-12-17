import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_app/core/services/adhan_service.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';
import 'package:islami_app/features/prayer_times/data/repos/prayer_times_repo.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_state.dart';
import 'package:islami_app/features/prayer_times/logic/prayer_notification_scheduler.dart';
import 'package:islami_app/features/prayer_times/logic/cubit/prayer_times_cubit_methods.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final PrayerTimesRepo _repo;
  final PrayerNotificationScheduler _scheduler;

  PrayerTimesCubit(this._repo, AdhanService adhanService)
    : _scheduler = PrayerNotificationScheduler(adhanService),
      super(const PrayerTimesState.initial());

  Future<void> getPrayerTimes({bool showLoading = true}) async {
    if (showLoading && state is! Success) {
      emit(const PrayerTimesState.loading());
    }
    await PrayerTimesCubitMethods.fetchPrayerTimes(_repo, _scheduler, emit);
  }

  PrayerTimesResponse? get _currentData =>
      state is Success ? (state as Success).data : null;
  Future<void> toggleAdhan(bool enabled) async =>
      await _scheduler.toggleAdhan(enabled, _currentData);
  Future<void> toggleSalahReminder(bool enabled) async =>
      await _scheduler.toggleSalahReminder(enabled, _currentData);
  Future<void> toggleAzkarReminder(bool enabled) async =>
      await _scheduler.toggleAzkarReminder(enabled, _currentData);
  Future<void> updateSalahInterval(int hours) async =>
      await _scheduler.updateSalahInterval(hours, _currentData);
  Future<void> updateAzkarInterval(int hours) async =>
      await _scheduler.updateAzkarInterval(hours, _currentData);
}
