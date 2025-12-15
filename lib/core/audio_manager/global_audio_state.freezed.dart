// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_audio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GlobalAudioState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalAudioState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalAudioState()';
}


}

/// @nodoc
class $GlobalAudioStateCopyWith<$Res>  {
$GlobalAudioStateCopyWith(GlobalAudioState _, $Res Function(GlobalAudioState) __);
}


/// Adds pattern-matching-related methods to [GlobalAudioState].
extension GlobalAudioStatePatterns on GlobalAudioState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Idle value)?  idle,TResult Function( Loading value)?  loading,TResult Function( PlayingQuran value)?  playingQuran,TResult Function( PlayingRadio value)?  playingRadio,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Idle() when idle != null:
return idle(_that);case Loading() when loading != null:
return loading(_that);case PlayingQuran() when playingQuran != null:
return playingQuran(_that);case PlayingRadio() when playingRadio != null:
return playingRadio(_that);case Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Idle value)  idle,required TResult Function( Loading value)  loading,required TResult Function( PlayingQuran value)  playingQuran,required TResult Function( PlayingRadio value)  playingRadio,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case Idle():
return idle(_that);case Loading():
return loading(_that);case PlayingQuran():
return playingQuran(_that);case PlayingRadio():
return playingRadio(_that);case Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Idle value)?  idle,TResult? Function( Loading value)?  loading,TResult? Function( PlayingQuran value)?  playingQuran,TResult? Function( PlayingRadio value)?  playingRadio,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case Idle() when idle != null:
return idle(_that);case Loading() when loading != null:
return loading(_that);case PlayingQuran() when playingQuran != null:
return playingQuran(_that);case PlayingRadio() when playingRadio != null:
return playingRadio(_that);case Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function( int surahNumber,  String surahName,  bool isPlaying,  double volume,  Duration position,  Duration total)?  playingQuran,TResult Function( String radioUrl,  String radioName,  bool isPlaying,  double volume)?  playingRadio,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Idle() when idle != null:
return idle();case Loading() when loading != null:
return loading();case PlayingQuran() when playingQuran != null:
return playingQuran(_that.surahNumber,_that.surahName,_that.isPlaying,_that.volume,_that.position,_that.total);case PlayingRadio() when playingRadio != null:
return playingRadio(_that.radioUrl,_that.radioName,_that.isPlaying,_that.volume);case Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function( int surahNumber,  String surahName,  bool isPlaying,  double volume,  Duration position,  Duration total)  playingQuran,required TResult Function( String radioUrl,  String radioName,  bool isPlaying,  double volume)  playingRadio,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case Idle():
return idle();case Loading():
return loading();case PlayingQuran():
return playingQuran(_that.surahNumber,_that.surahName,_that.isPlaying,_that.volume,_that.position,_that.total);case PlayingRadio():
return playingRadio(_that.radioUrl,_that.radioName,_that.isPlaying,_that.volume);case Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function( int surahNumber,  String surahName,  bool isPlaying,  double volume,  Duration position,  Duration total)?  playingQuran,TResult? Function( String radioUrl,  String radioName,  bool isPlaying,  double volume)?  playingRadio,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case Idle() when idle != null:
return idle();case Loading() when loading != null:
return loading();case PlayingQuran() when playingQuran != null:
return playingQuran(_that.surahNumber,_that.surahName,_that.isPlaying,_that.volume,_that.position,_that.total);case PlayingRadio() when playingRadio != null:
return playingRadio(_that.radioUrl,_that.radioName,_that.isPlaying,_that.volume);case Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Idle implements GlobalAudioState {
  const Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalAudioState.idle()';
}


}




/// @nodoc


class Loading implements GlobalAudioState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalAudioState.loading()';
}


}




/// @nodoc


class PlayingQuran implements GlobalAudioState {
  const PlayingQuran({required this.surahNumber, required this.surahName, required this.isPlaying, required this.volume, required this.position, required this.total});
  

 final  int surahNumber;
 final  String surahName;
 final  bool isPlaying;
 final  double volume;
 final  Duration position;
 final  Duration total;

/// Create a copy of GlobalAudioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayingQuranCopyWith<PlayingQuran> get copyWith => _$PlayingQuranCopyWithImpl<PlayingQuran>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayingQuran&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.surahName, surahName) || other.surahName == surahName)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.position, position) || other.position == position)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,surahNumber,surahName,isPlaying,volume,position,total);

@override
String toString() {
  return 'GlobalAudioState.playingQuran(surahNumber: $surahNumber, surahName: $surahName, isPlaying: $isPlaying, volume: $volume, position: $position, total: $total)';
}


}

/// @nodoc
abstract mixin class $PlayingQuranCopyWith<$Res> implements $GlobalAudioStateCopyWith<$Res> {
  factory $PlayingQuranCopyWith(PlayingQuran value, $Res Function(PlayingQuran) _then) = _$PlayingQuranCopyWithImpl;
@useResult
$Res call({
 int surahNumber, String surahName, bool isPlaying, double volume, Duration position, Duration total
});




}
/// @nodoc
class _$PlayingQuranCopyWithImpl<$Res>
    implements $PlayingQuranCopyWith<$Res> {
  _$PlayingQuranCopyWithImpl(this._self, this._then);

  final PlayingQuran _self;
  final $Res Function(PlayingQuran) _then;

/// Create a copy of GlobalAudioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? surahName = null,Object? isPlaying = null,Object? volume = null,Object? position = null,Object? total = null,}) {
  return _then(PlayingQuran(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,surahName: null == surahName ? _self.surahName : surahName // ignore: cast_nullable_to_non_nullable
as String,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc


class PlayingRadio implements GlobalAudioState {
  const PlayingRadio({required this.radioUrl, required this.radioName, required this.isPlaying, required this.volume});
  

 final  String radioUrl;
 final  String radioName;
 final  bool isPlaying;
 final  double volume;

/// Create a copy of GlobalAudioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayingRadioCopyWith<PlayingRadio> get copyWith => _$PlayingRadioCopyWithImpl<PlayingRadio>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayingRadio&&(identical(other.radioUrl, radioUrl) || other.radioUrl == radioUrl)&&(identical(other.radioName, radioName) || other.radioName == radioName)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.volume, volume) || other.volume == volume));
}


@override
int get hashCode => Object.hash(runtimeType,radioUrl,radioName,isPlaying,volume);

@override
String toString() {
  return 'GlobalAudioState.playingRadio(radioUrl: $radioUrl, radioName: $radioName, isPlaying: $isPlaying, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $PlayingRadioCopyWith<$Res> implements $GlobalAudioStateCopyWith<$Res> {
  factory $PlayingRadioCopyWith(PlayingRadio value, $Res Function(PlayingRadio) _then) = _$PlayingRadioCopyWithImpl;
@useResult
$Res call({
 String radioUrl, String radioName, bool isPlaying, double volume
});




}
/// @nodoc
class _$PlayingRadioCopyWithImpl<$Res>
    implements $PlayingRadioCopyWith<$Res> {
  _$PlayingRadioCopyWithImpl(this._self, this._then);

  final PlayingRadio _self;
  final $Res Function(PlayingRadio) _then;

/// Create a copy of GlobalAudioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? radioUrl = null,Object? radioName = null,Object? isPlaying = null,Object? volume = null,}) {
  return _then(PlayingRadio(
radioUrl: null == radioUrl ? _self.radioUrl : radioUrl // ignore: cast_nullable_to_non_nullable
as String,radioName: null == radioName ? _self.radioName : radioName // ignore: cast_nullable_to_non_nullable
as String,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class Error implements GlobalAudioState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of GlobalAudioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GlobalAudioState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $GlobalAudioStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of GlobalAudioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
