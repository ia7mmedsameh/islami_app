import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:islami_app/features/prayer_times/data/models/prayer_times_model.dart';

part 'prayer_times_state.freezed.dart';

@freezed
class PrayerTimesState with _$PrayerTimesState {
  const factory PrayerTimesState.initial() = _Initial;
  const factory PrayerTimesState.loading() = Loading;
  const factory PrayerTimesState.success(PrayerTimesResponse data) = Success;
  const factory PrayerTimesState.error(String message) = Error;
}
