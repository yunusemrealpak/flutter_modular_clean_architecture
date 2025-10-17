// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppEvent {

 int get index;
/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppEventCopyWith<AppEvent> get copyWith => _$AppEventCopyWithImpl<AppEvent>(this as AppEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppEvent&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'AppEvent(index: $index)';
}


}

/// @nodoc
abstract mixin class $AppEventCopyWith<$Res>  {
  factory $AppEventCopyWith(AppEvent value, $Res Function(AppEvent) _then) = _$AppEventCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$AppEventCopyWithImpl<$Res>
    implements $AppEventCopyWith<$Res> {
  _$AppEventCopyWithImpl(this._self, this._then);

  final AppEvent _self;
  final $Res Function(AppEvent) _then;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppEvent].
extension AppEventPatterns on AppEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppEventChangeTabIndex value)?  changeTabIndex,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppEventChangeTabIndex() when changeTabIndex != null:
return changeTabIndex(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppEventChangeTabIndex value)  changeTabIndex,}){
final _that = this;
switch (_that) {
case AppEventChangeTabIndex():
return changeTabIndex(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppEventChangeTabIndex value)?  changeTabIndex,}){
final _that = this;
switch (_that) {
case AppEventChangeTabIndex() when changeTabIndex != null:
return changeTabIndex(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int index)?  changeTabIndex,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppEventChangeTabIndex() when changeTabIndex != null:
return changeTabIndex(_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int index)  changeTabIndex,}) {final _that = this;
switch (_that) {
case AppEventChangeTabIndex():
return changeTabIndex(_that.index);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int index)?  changeTabIndex,}) {final _that = this;
switch (_that) {
case AppEventChangeTabIndex() when changeTabIndex != null:
return changeTabIndex(_that.index);case _:
  return null;

}
}

}

/// @nodoc


class AppEventChangeTabIndex implements AppEvent {
  const AppEventChangeTabIndex({required this.index});
  

@override final  int index;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppEventChangeTabIndexCopyWith<AppEventChangeTabIndex> get copyWith => _$AppEventChangeTabIndexCopyWithImpl<AppEventChangeTabIndex>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppEventChangeTabIndex&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'AppEvent.changeTabIndex(index: $index)';
}


}

/// @nodoc
abstract mixin class $AppEventChangeTabIndexCopyWith<$Res> implements $AppEventCopyWith<$Res> {
  factory $AppEventChangeTabIndexCopyWith(AppEventChangeTabIndex value, $Res Function(AppEventChangeTabIndex) _then) = _$AppEventChangeTabIndexCopyWithImpl;
@override @useResult
$Res call({
 int index
});




}
/// @nodoc
class _$AppEventChangeTabIndexCopyWithImpl<$Res>
    implements $AppEventChangeTabIndexCopyWith<$Res> {
  _$AppEventChangeTabIndexCopyWithImpl(this._self, this._then);

  final AppEventChangeTabIndex _self;
  final $Res Function(AppEventChangeTabIndex) _then;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(AppEventChangeTabIndex(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$AppState {

 int get currentTabIndex;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.currentTabIndex, currentTabIndex) || other.currentTabIndex == currentTabIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentTabIndex);

@override
String toString() {
  return 'AppState(currentTabIndex: $currentTabIndex)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 int currentTabIndex
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentTabIndex = null,}) {
  return _then(_self.copyWith(
currentTabIndex: null == currentTabIndex ? _self.currentTabIndex : currentTabIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppStateInitial value)?  initial,TResult Function( AppStateTabChanged value)?  tabChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppStateInitial() when initial != null:
return initial(_that);case AppStateTabChanged() when tabChanged != null:
return tabChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppStateInitial value)  initial,required TResult Function( AppStateTabChanged value)  tabChanged,}){
final _that = this;
switch (_that) {
case AppStateInitial():
return initial(_that);case AppStateTabChanged():
return tabChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppStateInitial value)?  initial,TResult? Function( AppStateTabChanged value)?  tabChanged,}){
final _that = this;
switch (_that) {
case AppStateInitial() when initial != null:
return initial(_that);case AppStateTabChanged() when tabChanged != null:
return tabChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int currentTabIndex)?  initial,TResult Function( int currentTabIndex)?  tabChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppStateInitial() when initial != null:
return initial(_that.currentTabIndex);case AppStateTabChanged() when tabChanged != null:
return tabChanged(_that.currentTabIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int currentTabIndex)  initial,required TResult Function( int currentTabIndex)  tabChanged,}) {final _that = this;
switch (_that) {
case AppStateInitial():
return initial(_that.currentTabIndex);case AppStateTabChanged():
return tabChanged(_that.currentTabIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int currentTabIndex)?  initial,TResult? Function( int currentTabIndex)?  tabChanged,}) {final _that = this;
switch (_that) {
case AppStateInitial() when initial != null:
return initial(_that.currentTabIndex);case AppStateTabChanged() when tabChanged != null:
return tabChanged(_that.currentTabIndex);case _:
  return null;

}
}

}

/// @nodoc


class AppStateInitial implements AppState {
  const AppStateInitial({this.currentTabIndex = 0});
  

@override@JsonKey() final  int currentTabIndex;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateInitialCopyWith<AppStateInitial> get copyWith => _$AppStateInitialCopyWithImpl<AppStateInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStateInitial&&(identical(other.currentTabIndex, currentTabIndex) || other.currentTabIndex == currentTabIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentTabIndex);

@override
String toString() {
  return 'AppState.initial(currentTabIndex: $currentTabIndex)';
}


}

/// @nodoc
abstract mixin class $AppStateInitialCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory $AppStateInitialCopyWith(AppStateInitial value, $Res Function(AppStateInitial) _then) = _$AppStateInitialCopyWithImpl;
@override @useResult
$Res call({
 int currentTabIndex
});




}
/// @nodoc
class _$AppStateInitialCopyWithImpl<$Res>
    implements $AppStateInitialCopyWith<$Res> {
  _$AppStateInitialCopyWithImpl(this._self, this._then);

  final AppStateInitial _self;
  final $Res Function(AppStateInitial) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentTabIndex = null,}) {
  return _then(AppStateInitial(
currentTabIndex: null == currentTabIndex ? _self.currentTabIndex : currentTabIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class AppStateTabChanged implements AppState {
  const AppStateTabChanged({required this.currentTabIndex});
  

@override final  int currentTabIndex;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateTabChangedCopyWith<AppStateTabChanged> get copyWith => _$AppStateTabChangedCopyWithImpl<AppStateTabChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStateTabChanged&&(identical(other.currentTabIndex, currentTabIndex) || other.currentTabIndex == currentTabIndex));
}


@override
int get hashCode => Object.hash(runtimeType,currentTabIndex);

@override
String toString() {
  return 'AppState.tabChanged(currentTabIndex: $currentTabIndex)';
}


}

/// @nodoc
abstract mixin class $AppStateTabChangedCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory $AppStateTabChangedCopyWith(AppStateTabChanged value, $Res Function(AppStateTabChanged) _then) = _$AppStateTabChangedCopyWithImpl;
@override @useResult
$Res call({
 int currentTabIndex
});




}
/// @nodoc
class _$AppStateTabChangedCopyWithImpl<$Res>
    implements $AppStateTabChangedCopyWith<$Res> {
  _$AppStateTabChangedCopyWithImpl(this._self, this._then);

  final AppStateTabChanged _self;
  final $Res Function(AppStateTabChanged) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentTabIndex = null,}) {
  return _then(AppStateTabChanged(
currentTabIndex: null == currentTabIndex ? _self.currentTabIndex : currentTabIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
