// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ahadith_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AhadithState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AhadithState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AhadithState()';
}


}

/// @nodoc
class $AhadithStateCopyWith<$Res>  {
$AhadithStateCopyWith(AhadithState _, $Res Function(AhadithState) __);
}


/// Adds pattern-matching-related methods to [AhadithState].
extension AhadithStatePatterns on AhadithState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( AhadithLoading value)?  ahadithLoading,TResult Function( AhadithSuccess value)?  ahadithSuccess,TResult Function( AhadithError value)?  ahadithError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case AhadithLoading() when ahadithLoading != null:
return ahadithLoading(_that);case AhadithSuccess() when ahadithSuccess != null:
return ahadithSuccess(_that);case AhadithError() when ahadithError != null:
return ahadithError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( AhadithLoading value)  ahadithLoading,required TResult Function( AhadithSuccess value)  ahadithSuccess,required TResult Function( AhadithError value)  ahadithError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case AhadithLoading():
return ahadithLoading(_that);case AhadithSuccess():
return ahadithSuccess(_that);case AhadithError():
return ahadithError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( AhadithLoading value)?  ahadithLoading,TResult? Function( AhadithSuccess value)?  ahadithSuccess,TResult? Function( AhadithError value)?  ahadithError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case AhadithLoading() when ahadithLoading != null:
return ahadithLoading(_that);case AhadithSuccess() when ahadithSuccess != null:
return ahadithSuccess(_that);case AhadithError() when ahadithError != null:
return ahadithError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  ahadithLoading,TResult Function( AhadithResponseModel ahadithResponseModel)?  ahadithSuccess,TResult Function( ApiErrorModel apiErrorModel)?  ahadithError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case AhadithLoading() when ahadithLoading != null:
return ahadithLoading();case AhadithSuccess() when ahadithSuccess != null:
return ahadithSuccess(_that.ahadithResponseModel);case AhadithError() when ahadithError != null:
return ahadithError(_that.apiErrorModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  ahadithLoading,required TResult Function( AhadithResponseModel ahadithResponseModel)  ahadithSuccess,required TResult Function( ApiErrorModel apiErrorModel)  ahadithError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case AhadithLoading():
return ahadithLoading();case AhadithSuccess():
return ahadithSuccess(_that.ahadithResponseModel);case AhadithError():
return ahadithError(_that.apiErrorModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  ahadithLoading,TResult? Function( AhadithResponseModel ahadithResponseModel)?  ahadithSuccess,TResult? Function( ApiErrorModel apiErrorModel)?  ahadithError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case AhadithLoading() when ahadithLoading != null:
return ahadithLoading();case AhadithSuccess() when ahadithSuccess != null:
return ahadithSuccess(_that.ahadithResponseModel);case AhadithError() when ahadithError != null:
return ahadithError(_that.apiErrorModel);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AhadithState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AhadithState.initial()';
}


}




/// @nodoc


class AhadithLoading implements AhadithState {
  const AhadithLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AhadithLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AhadithState.ahadithLoading()';
}


}




/// @nodoc


class AhadithSuccess implements AhadithState {
  const AhadithSuccess(this.ahadithResponseModel);
  

 final  AhadithResponseModel ahadithResponseModel;

/// Create a copy of AhadithState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AhadithSuccessCopyWith<AhadithSuccess> get copyWith => _$AhadithSuccessCopyWithImpl<AhadithSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AhadithSuccess&&(identical(other.ahadithResponseModel, ahadithResponseModel) || other.ahadithResponseModel == ahadithResponseModel));
}


@override
int get hashCode => Object.hash(runtimeType,ahadithResponseModel);

@override
String toString() {
  return 'AhadithState.ahadithSuccess(ahadithResponseModel: $ahadithResponseModel)';
}


}

/// @nodoc
abstract mixin class $AhadithSuccessCopyWith<$Res> implements $AhadithStateCopyWith<$Res> {
  factory $AhadithSuccessCopyWith(AhadithSuccess value, $Res Function(AhadithSuccess) _then) = _$AhadithSuccessCopyWithImpl;
@useResult
$Res call({
 AhadithResponseModel ahadithResponseModel
});




}
/// @nodoc
class _$AhadithSuccessCopyWithImpl<$Res>
    implements $AhadithSuccessCopyWith<$Res> {
  _$AhadithSuccessCopyWithImpl(this._self, this._then);

  final AhadithSuccess _self;
  final $Res Function(AhadithSuccess) _then;

/// Create a copy of AhadithState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ahadithResponseModel = null,}) {
  return _then(AhadithSuccess(
null == ahadithResponseModel ? _self.ahadithResponseModel : ahadithResponseModel // ignore: cast_nullable_to_non_nullable
as AhadithResponseModel,
  ));
}


}

/// @nodoc


class AhadithError implements AhadithState {
  const AhadithError(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of AhadithState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AhadithErrorCopyWith<AhadithError> get copyWith => _$AhadithErrorCopyWithImpl<AhadithError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AhadithError&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'AhadithState.ahadithError(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $AhadithErrorCopyWith<$Res> implements $AhadithStateCopyWith<$Res> {
  factory $AhadithErrorCopyWith(AhadithError value, $Res Function(AhadithError) _then) = _$AhadithErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$AhadithErrorCopyWithImpl<$Res>
    implements $AhadithErrorCopyWith<$Res> {
  _$AhadithErrorCopyWithImpl(this._self, this._then);

  final AhadithError _self;
  final $Res Function(AhadithError) _then;

/// Create a copy of AhadithState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(AhadithError(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
