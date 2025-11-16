// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'radios_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RadiosState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RadiosState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RadiosState()';
}


}

/// @nodoc
class $RadiosStateCopyWith<$Res>  {
$RadiosStateCopyWith(RadiosState _, $Res Function(RadiosState) __);
}


/// Adds pattern-matching-related methods to [RadiosState].
extension RadiosStatePatterns on RadiosState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( RadiosLoading value)?  radiosLoading,TResult Function( RadiosSuccess value)?  radiosSuccess,TResult Function( RadiosError value)?  radiosError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case RadiosLoading() when radiosLoading != null:
return radiosLoading(_that);case RadiosSuccess() when radiosSuccess != null:
return radiosSuccess(_that);case RadiosError() when radiosError != null:
return radiosError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( RadiosLoading value)  radiosLoading,required TResult Function( RadiosSuccess value)  radiosSuccess,required TResult Function( RadiosError value)  radiosError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case RadiosLoading():
return radiosLoading(_that);case RadiosSuccess():
return radiosSuccess(_that);case RadiosError():
return radiosError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( RadiosLoading value)?  radiosLoading,TResult? Function( RadiosSuccess value)?  radiosSuccess,TResult? Function( RadiosError value)?  radiosError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case RadiosLoading() when radiosLoading != null:
return radiosLoading(_that);case RadiosSuccess() when radiosSuccess != null:
return radiosSuccess(_that);case RadiosError() when radiosError != null:
return radiosError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  radiosLoading,TResult Function( RadioResponseModel radioResponseModel)?  radiosSuccess,TResult Function( String message)?  radiosError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case RadiosLoading() when radiosLoading != null:
return radiosLoading();case RadiosSuccess() when radiosSuccess != null:
return radiosSuccess(_that.radioResponseModel);case RadiosError() when radiosError != null:
return radiosError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  radiosLoading,required TResult Function( RadioResponseModel radioResponseModel)  radiosSuccess,required TResult Function( String message)  radiosError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case RadiosLoading():
return radiosLoading();case RadiosSuccess():
return radiosSuccess(_that.radioResponseModel);case RadiosError():
return radiosError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  radiosLoading,TResult? Function( RadioResponseModel radioResponseModel)?  radiosSuccess,TResult? Function( String message)?  radiosError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case RadiosLoading() when radiosLoading != null:
return radiosLoading();case RadiosSuccess() when radiosSuccess != null:
return radiosSuccess(_that.radioResponseModel);case RadiosError() when radiosError != null:
return radiosError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements RadiosState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RadiosState.initial()';
}


}




/// @nodoc


class RadiosLoading implements RadiosState {
  const RadiosLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RadiosLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RadiosState.radiosLoading()';
}


}




/// @nodoc


class RadiosSuccess implements RadiosState {
  const RadiosSuccess(this.radioResponseModel);
  

 final  RadioResponseModel radioResponseModel;

/// Create a copy of RadiosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RadiosSuccessCopyWith<RadiosSuccess> get copyWith => _$RadiosSuccessCopyWithImpl<RadiosSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RadiosSuccess&&(identical(other.radioResponseModel, radioResponseModel) || other.radioResponseModel == radioResponseModel));
}


@override
int get hashCode => Object.hash(runtimeType,radioResponseModel);

@override
String toString() {
  return 'RadiosState.radiosSuccess(radioResponseModel: $radioResponseModel)';
}


}

/// @nodoc
abstract mixin class $RadiosSuccessCopyWith<$Res> implements $RadiosStateCopyWith<$Res> {
  factory $RadiosSuccessCopyWith(RadiosSuccess value, $Res Function(RadiosSuccess) _then) = _$RadiosSuccessCopyWithImpl;
@useResult
$Res call({
 RadioResponseModel radioResponseModel
});




}
/// @nodoc
class _$RadiosSuccessCopyWithImpl<$Res>
    implements $RadiosSuccessCopyWith<$Res> {
  _$RadiosSuccessCopyWithImpl(this._self, this._then);

  final RadiosSuccess _self;
  final $Res Function(RadiosSuccess) _then;

/// Create a copy of RadiosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? radioResponseModel = null,}) {
  return _then(RadiosSuccess(
null == radioResponseModel ? _self.radioResponseModel : radioResponseModel // ignore: cast_nullable_to_non_nullable
as RadioResponseModel,
  ));
}


}

/// @nodoc


class RadiosError implements RadiosState {
  const RadiosError(this.message);
  

 final  String message;

/// Create a copy of RadiosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RadiosErrorCopyWith<RadiosError> get copyWith => _$RadiosErrorCopyWithImpl<RadiosError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RadiosError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RadiosState.radiosError(message: $message)';
}


}

/// @nodoc
abstract mixin class $RadiosErrorCopyWith<$Res> implements $RadiosStateCopyWith<$Res> {
  factory $RadiosErrorCopyWith(RadiosError value, $Res Function(RadiosError) _then) = _$RadiosErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RadiosErrorCopyWithImpl<$Res>
    implements $RadiosErrorCopyWith<$Res> {
  _$RadiosErrorCopyWithImpl(this._self, this._then);

  final RadiosError _self;
  final $Res Function(RadiosError) _then;

/// Create a copy of RadiosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RadiosError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
