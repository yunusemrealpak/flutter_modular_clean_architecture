// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionData {

/// Current authenticated user
 UserSession? get user;/// Access token
 String? get accessToken;/// Refresh token
 String? get refreshToken;/// Authentication status
 bool get isAuthenticated;/// App settings
 Map<String, dynamic> get settings;/// Last activity timestamp
 DateTime? get lastActivity;
/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionDataCopyWith<SessionData> get copyWith => _$SessionDataCopyWithImpl<SessionData>(this as SessionData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionData&&(identical(other.user, user) || other.user == user)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated)&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.lastActivity, lastActivity) || other.lastActivity == lastActivity));
}


@override
int get hashCode => Object.hash(runtimeType,user,accessToken,refreshToken,isAuthenticated,const DeepCollectionEquality().hash(settings),lastActivity);

@override
String toString() {
  return 'SessionData(user: $user, accessToken: $accessToken, refreshToken: $refreshToken, isAuthenticated: $isAuthenticated, settings: $settings, lastActivity: $lastActivity)';
}


}

/// @nodoc
abstract mixin class $SessionDataCopyWith<$Res>  {
  factory $SessionDataCopyWith(SessionData value, $Res Function(SessionData) _then) = _$SessionDataCopyWithImpl;
@useResult
$Res call({
 UserSession? user, String? accessToken, String? refreshToken, bool isAuthenticated, Map<String, dynamic> settings, DateTime? lastActivity
});


$UserSessionCopyWith<$Res>? get user;

}
/// @nodoc
class _$SessionDataCopyWithImpl<$Res>
    implements $SessionDataCopyWith<$Res> {
  _$SessionDataCopyWithImpl(this._self, this._then);

  final SessionData _self;
  final $Res Function(SessionData) _then;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? isAuthenticated = null,Object? settings = null,Object? lastActivity = freezed,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserSession?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,lastActivity: freezed == lastActivity ? _self.lastActivity : lastActivity // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSessionCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserSessionCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionData].
extension SessionDataPatterns on SessionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionData value)  $default,){
final _that = this;
switch (_that) {
case _SessionData():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionData value)?  $default,){
final _that = this;
switch (_that) {
case _SessionData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserSession? user,  String? accessToken,  String? refreshToken,  bool isAuthenticated,  Map<String, dynamic> settings,  DateTime? lastActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionData() when $default != null:
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.isAuthenticated,_that.settings,_that.lastActivity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserSession? user,  String? accessToken,  String? refreshToken,  bool isAuthenticated,  Map<String, dynamic> settings,  DateTime? lastActivity)  $default,) {final _that = this;
switch (_that) {
case _SessionData():
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.isAuthenticated,_that.settings,_that.lastActivity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserSession? user,  String? accessToken,  String? refreshToken,  bool isAuthenticated,  Map<String, dynamic> settings,  DateTime? lastActivity)?  $default,) {final _that = this;
switch (_that) {
case _SessionData() when $default != null:
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.isAuthenticated,_that.settings,_that.lastActivity);case _:
  return null;

}
}

}

/// @nodoc


class _SessionData implements SessionData {
  const _SessionData({this.user, this.accessToken, this.refreshToken, this.isAuthenticated = false, final  Map<String, dynamic> settings = const {}, this.lastActivity}): _settings = settings;
  

/// Current authenticated user
@override final  UserSession? user;
/// Access token
@override final  String? accessToken;
/// Refresh token
@override final  String? refreshToken;
/// Authentication status
@override@JsonKey() final  bool isAuthenticated;
/// App settings
 final  Map<String, dynamic> _settings;
/// App settings
@override@JsonKey() Map<String, dynamic> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}

/// Last activity timestamp
@override final  DateTime? lastActivity;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionDataCopyWith<_SessionData> get copyWith => __$SessionDataCopyWithImpl<_SessionData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionData&&(identical(other.user, user) || other.user == user)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated)&&const DeepCollectionEquality().equals(other._settings, _settings)&&(identical(other.lastActivity, lastActivity) || other.lastActivity == lastActivity));
}


@override
int get hashCode => Object.hash(runtimeType,user,accessToken,refreshToken,isAuthenticated,const DeepCollectionEquality().hash(_settings),lastActivity);

@override
String toString() {
  return 'SessionData(user: $user, accessToken: $accessToken, refreshToken: $refreshToken, isAuthenticated: $isAuthenticated, settings: $settings, lastActivity: $lastActivity)';
}


}

/// @nodoc
abstract mixin class _$SessionDataCopyWith<$Res> implements $SessionDataCopyWith<$Res> {
  factory _$SessionDataCopyWith(_SessionData value, $Res Function(_SessionData) _then) = __$SessionDataCopyWithImpl;
@override @useResult
$Res call({
 UserSession? user, String? accessToken, String? refreshToken, bool isAuthenticated, Map<String, dynamic> settings, DateTime? lastActivity
});


@override $UserSessionCopyWith<$Res>? get user;

}
/// @nodoc
class __$SessionDataCopyWithImpl<$Res>
    implements _$SessionDataCopyWith<$Res> {
  __$SessionDataCopyWithImpl(this._self, this._then);

  final _SessionData _self;
  final $Res Function(_SessionData) _then;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? isAuthenticated = null,Object? settings = null,Object? lastActivity = freezed,}) {
  return _then(_SessionData(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserSession?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,lastActivity: freezed == lastActivity ? _self.lastActivity : lastActivity // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSessionCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserSessionCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
