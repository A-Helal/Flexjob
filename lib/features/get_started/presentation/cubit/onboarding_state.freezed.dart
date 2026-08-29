// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState()';
}


}

/// @nodoc
class $OnboardingStateCopyWith<$Res>  {
$OnboardingStateCopyWith(OnboardingState _, $Res Function(OnboardingState) __);
}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnboardingInitial value)?  initial,TResult Function( _OnboardingLoading value)?  loading,TResult Function( _OnboardingCompleted value)?  completed,TResult Function( _OnboardingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingInitial() when initial != null:
return initial(_that);case _OnboardingLoading() when loading != null:
return loading(_that);case _OnboardingCompleted() when completed != null:
return completed(_that);case _OnboardingError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnboardingInitial value)  initial,required TResult Function( _OnboardingLoading value)  loading,required TResult Function( _OnboardingCompleted value)  completed,required TResult Function( _OnboardingError value)  error,}){
final _that = this;
switch (_that) {
case _OnboardingInitial():
return initial(_that);case _OnboardingLoading():
return loading(_that);case _OnboardingCompleted():
return completed(_that);case _OnboardingError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnboardingInitial value)?  initial,TResult? Function( _OnboardingLoading value)?  loading,TResult? Function( _OnboardingCompleted value)?  completed,TResult? Function( _OnboardingError value)?  error,}){
final _that = this;
switch (_that) {
case _OnboardingInitial() when initial != null:
return initial(_that);case _OnboardingLoading() when loading != null:
return loading(_that);case _OnboardingCompleted() when completed != null:
return completed(_that);case _OnboardingError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  completed,TResult Function()?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingInitial() when initial != null:
return initial();case _OnboardingLoading() when loading != null:
return loading();case _OnboardingCompleted() when completed != null:
return completed();case _OnboardingError() when error != null:
return error();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  completed,required TResult Function()  error,}) {final _that = this;
switch (_that) {
case _OnboardingInitial():
return initial();case _OnboardingLoading():
return loading();case _OnboardingCompleted():
return completed();case _OnboardingError():
return error();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  completed,TResult? Function()?  error,}) {final _that = this;
switch (_that) {
case _OnboardingInitial() when initial != null:
return initial();case _OnboardingLoading() when loading != null:
return loading();case _OnboardingCompleted() when completed != null:
return completed();case _OnboardingError() when error != null:
return error();case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingInitial implements OnboardingState {
  const _OnboardingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.initial()';
}


}




/// @nodoc


class _OnboardingLoading implements OnboardingState {
  const _OnboardingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.loading()';
}


}




/// @nodoc


class _OnboardingCompleted implements OnboardingState {
  const _OnboardingCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.completed()';
}


}




/// @nodoc


class _OnboardingError implements OnboardingState {
  const _OnboardingError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.error()';
}


}




// dart format on
