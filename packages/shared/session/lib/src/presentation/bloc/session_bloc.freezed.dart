// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionEvent()';
}


}

/// @nodoc
class $SessionEventCopyWith<$Res>  {
$SessionEventCopyWith(SessionEvent _, $Res Function(SessionEvent) __);
}


/// Adds pattern-matching-related methods to [SessionEvent].
extension SessionEventPatterns on SessionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionEventLogin value)?  login,TResult Function( SessionEventLogout value)?  logout,TResult Function( SessionEventUpdateUser value)?  updateUser,TResult Function( SessionEventUpdateSettings value)?  updateSettings,TResult Function( SessionEventRefreshToken value)?  refreshToken,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionEventLogin() when login != null:
return login(_that);case SessionEventLogout() when logout != null:
return logout(_that);case SessionEventUpdateUser() when updateUser != null:
return updateUser(_that);case SessionEventUpdateSettings() when updateSettings != null:
return updateSettings(_that);case SessionEventRefreshToken() when refreshToken != null:
return refreshToken(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionEventLogin value)  login,required TResult Function( SessionEventLogout value)  logout,required TResult Function( SessionEventUpdateUser value)  updateUser,required TResult Function( SessionEventUpdateSettings value)  updateSettings,required TResult Function( SessionEventRefreshToken value)  refreshToken,}){
final _that = this;
switch (_that) {
case SessionEventLogin():
return login(_that);case SessionEventLogout():
return logout(_that);case SessionEventUpdateUser():
return updateUser(_that);case SessionEventUpdateSettings():
return updateSettings(_that);case SessionEventRefreshToken():
return refreshToken(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionEventLogin value)?  login,TResult? Function( SessionEventLogout value)?  logout,TResult? Function( SessionEventUpdateUser value)?  updateUser,TResult? Function( SessionEventUpdateSettings value)?  updateSettings,TResult? Function( SessionEventRefreshToken value)?  refreshToken,}){
final _that = this;
switch (_that) {
case SessionEventLogin() when login != null:
return login(_that);case SessionEventLogout() when logout != null:
return logout(_that);case SessionEventUpdateUser() when updateUser != null:
return updateUser(_that);case SessionEventUpdateSettings() when updateSettings != null:
return updateSettings(_that);case SessionEventRefreshToken() when refreshToken != null:
return refreshToken(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( UserSession user,  String accessToken,  String? refreshToken)?  login,TResult Function()?  logout,TResult Function( UserSession user)?  updateUser,TResult Function( Map<String, dynamic> settings)?  updateSettings,TResult Function( String accessToken,  String? refreshToken)?  refreshToken,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionEventLogin() when login != null:
return login(_that.user,_that.accessToken,_that.refreshToken);case SessionEventLogout() when logout != null:
return logout();case SessionEventUpdateUser() when updateUser != null:
return updateUser(_that.user);case SessionEventUpdateSettings() when updateSettings != null:
return updateSettings(_that.settings);case SessionEventRefreshToken() when refreshToken != null:
return refreshToken(_that.accessToken,_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( UserSession user,  String accessToken,  String? refreshToken)  login,required TResult Function()  logout,required TResult Function( UserSession user)  updateUser,required TResult Function( Map<String, dynamic> settings)  updateSettings,required TResult Function( String accessToken,  String? refreshToken)  refreshToken,}) {final _that = this;
switch (_that) {
case SessionEventLogin():
return login(_that.user,_that.accessToken,_that.refreshToken);case SessionEventLogout():
return logout();case SessionEventUpdateUser():
return updateUser(_that.user);case SessionEventUpdateSettings():
return updateSettings(_that.settings);case SessionEventRefreshToken():
return refreshToken(_that.accessToken,_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( UserSession user,  String accessToken,  String? refreshToken)?  login,TResult? Function()?  logout,TResult? Function( UserSession user)?  updateUser,TResult? Function( Map<String, dynamic> settings)?  updateSettings,TResult? Function( String accessToken,  String? refreshToken)?  refreshToken,}) {final _that = this;
switch (_that) {
case SessionEventLogin() when login != null:
return login(_that.user,_that.accessToken,_that.refreshToken);case SessionEventLogout() when logout != null:
return logout();case SessionEventUpdateUser() when updateUser != null:
return updateUser(_that.user);case SessionEventUpdateSettings() when updateSettings != null:
return updateSettings(_that.settings);case SessionEventRefreshToken() when refreshToken != null:
return refreshToken(_that.accessToken,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc


class SessionEventLogin implements SessionEvent {
  const SessionEventLogin({required this.user, required this.accessToken, this.refreshToken});
  

 final  UserSession user;
 final  String accessToken;
 final  String? refreshToken;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionEventLoginCopyWith<SessionEventLogin> get copyWith => _$SessionEventLoginCopyWithImpl<SessionEventLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionEventLogin&&(identical(other.user, user) || other.user == user)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}


@override
int get hashCode => Object.hash(runtimeType,user,accessToken,refreshToken);

@override
String toString() {
  return 'SessionEvent.login(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $SessionEventLoginCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SessionEventLoginCopyWith(SessionEventLogin value, $Res Function(SessionEventLogin) _then) = _$SessionEventLoginCopyWithImpl;
@useResult
$Res call({
 UserSession user, String accessToken, String? refreshToken
});


$UserSessionCopyWith<$Res> get user;

}
/// @nodoc
class _$SessionEventLoginCopyWithImpl<$Res>
    implements $SessionEventLoginCopyWith<$Res> {
  _$SessionEventLoginCopyWithImpl(this._self, this._then);

  final SessionEventLogin _self;
  final $Res Function(SessionEventLogin) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,Object? accessToken = null,Object? refreshToken = freezed,}) {
  return _then(SessionEventLogin(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserSession,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSessionCopyWith<$Res> get user {
  
  return $UserSessionCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class SessionEventLogout implements SessionEvent {
  const SessionEventLogout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionEventLogout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionEvent.logout()';
}


}




/// @nodoc


class SessionEventUpdateUser implements SessionEvent {
  const SessionEventUpdateUser({required this.user});
  

 final  UserSession user;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionEventUpdateUserCopyWith<SessionEventUpdateUser> get copyWith => _$SessionEventUpdateUserCopyWithImpl<SessionEventUpdateUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionEventUpdateUser&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'SessionEvent.updateUser(user: $user)';
}


}

/// @nodoc
abstract mixin class $SessionEventUpdateUserCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SessionEventUpdateUserCopyWith(SessionEventUpdateUser value, $Res Function(SessionEventUpdateUser) _then) = _$SessionEventUpdateUserCopyWithImpl;
@useResult
$Res call({
 UserSession user
});


$UserSessionCopyWith<$Res> get user;

}
/// @nodoc
class _$SessionEventUpdateUserCopyWithImpl<$Res>
    implements $SessionEventUpdateUserCopyWith<$Res> {
  _$SessionEventUpdateUserCopyWithImpl(this._self, this._then);

  final SessionEventUpdateUser _self;
  final $Res Function(SessionEventUpdateUser) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(SessionEventUpdateUser(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserSession,
  ));
}

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSessionCopyWith<$Res> get user {
  
  return $UserSessionCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class SessionEventUpdateSettings implements SessionEvent {
  const SessionEventUpdateSettings({required final  Map<String, dynamic> settings}): _settings = settings;
  

 final  Map<String, dynamic> _settings;
 Map<String, dynamic> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}


/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionEventUpdateSettingsCopyWith<SessionEventUpdateSettings> get copyWith => _$SessionEventUpdateSettingsCopyWithImpl<SessionEventUpdateSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionEventUpdateSettings&&const DeepCollectionEquality().equals(other._settings, _settings));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_settings));

@override
String toString() {
  return 'SessionEvent.updateSettings(settings: $settings)';
}


}

/// @nodoc
abstract mixin class $SessionEventUpdateSettingsCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SessionEventUpdateSettingsCopyWith(SessionEventUpdateSettings value, $Res Function(SessionEventUpdateSettings) _then) = _$SessionEventUpdateSettingsCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> settings
});




}
/// @nodoc
class _$SessionEventUpdateSettingsCopyWithImpl<$Res>
    implements $SessionEventUpdateSettingsCopyWith<$Res> {
  _$SessionEventUpdateSettingsCopyWithImpl(this._self, this._then);

  final SessionEventUpdateSettings _self;
  final $Res Function(SessionEventUpdateSettings) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(SessionEventUpdateSettings(
settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class SessionEventRefreshToken implements SessionEvent {
  const SessionEventRefreshToken({required this.accessToken, this.refreshToken});
  

 final  String accessToken;
 final  String? refreshToken;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionEventRefreshTokenCopyWith<SessionEventRefreshToken> get copyWith => _$SessionEventRefreshTokenCopyWithImpl<SessionEventRefreshToken>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionEventRefreshToken&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'SessionEvent.refreshToken(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $SessionEventRefreshTokenCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SessionEventRefreshTokenCopyWith(SessionEventRefreshToken value, $Res Function(SessionEventRefreshToken) _then) = _$SessionEventRefreshTokenCopyWithImpl;
@useResult
$Res call({
 String accessToken, String? refreshToken
});




}
/// @nodoc
class _$SessionEventRefreshTokenCopyWithImpl<$Res>
    implements $SessionEventRefreshTokenCopyWith<$Res> {
  _$SessionEventRefreshTokenCopyWithImpl(this._self, this._then);

  final SessionEventRefreshToken _self;
  final $Res Function(SessionEventRefreshToken) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = freezed,}) {
  return _then(SessionEventRefreshToken(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState()';
}


}

/// @nodoc
class $SessionStateCopyWith<$Res>  {
$SessionStateCopyWith(SessionState _, $Res Function(SessionState) __);
}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionStateInitial value)?  initial,TResult Function( SessionStateAuthenticated value)?  authenticated,TResult Function( SessionStateUnauthenticated value)?  unauthenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionStateInitial() when initial != null:
return initial(_that);case SessionStateAuthenticated() when authenticated != null:
return authenticated(_that);case SessionStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionStateInitial value)  initial,required TResult Function( SessionStateAuthenticated value)  authenticated,required TResult Function( SessionStateUnauthenticated value)  unauthenticated,}){
final _that = this;
switch (_that) {
case SessionStateInitial():
return initial(_that);case SessionStateAuthenticated():
return authenticated(_that);case SessionStateUnauthenticated():
return unauthenticated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionStateInitial value)?  initial,TResult? Function( SessionStateAuthenticated value)?  authenticated,TResult? Function( SessionStateUnauthenticated value)?  unauthenticated,}){
final _that = this;
switch (_that) {
case SessionStateInitial() when initial != null:
return initial(_that);case SessionStateAuthenticated() when authenticated != null:
return authenticated(_that);case SessionStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( SessionData session)?  authenticated,TResult Function()?  unauthenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionStateInitial() when initial != null:
return initial();case SessionStateAuthenticated() when authenticated != null:
return authenticated(_that.session);case SessionStateUnauthenticated() when unauthenticated != null:
return unauthenticated();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( SessionData session)  authenticated,required TResult Function()  unauthenticated,}) {final _that = this;
switch (_that) {
case SessionStateInitial():
return initial();case SessionStateAuthenticated():
return authenticated(_that.session);case SessionStateUnauthenticated():
return unauthenticated();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( SessionData session)?  authenticated,TResult? Function()?  unauthenticated,}) {final _that = this;
switch (_that) {
case SessionStateInitial() when initial != null:
return initial();case SessionStateAuthenticated() when authenticated != null:
return authenticated(_that.session);case SessionStateUnauthenticated() when unauthenticated != null:
return unauthenticated();case _:
  return null;

}
}

}

/// @nodoc


class SessionStateInitial implements SessionState {
  const SessionStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState.initial()';
}


}




/// @nodoc


class SessionStateAuthenticated implements SessionState {
  const SessionStateAuthenticated(this.session);
  

 final  SessionData session;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStateAuthenticatedCopyWith<SessionStateAuthenticated> get copyWith => _$SessionStateAuthenticatedCopyWithImpl<SessionStateAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStateAuthenticated&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'SessionState.authenticated(session: $session)';
}


}

/// @nodoc
abstract mixin class $SessionStateAuthenticatedCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory $SessionStateAuthenticatedCopyWith(SessionStateAuthenticated value, $Res Function(SessionStateAuthenticated) _then) = _$SessionStateAuthenticatedCopyWithImpl;
@useResult
$Res call({
 SessionData session
});


$SessionDataCopyWith<$Res> get session;

}
/// @nodoc
class _$SessionStateAuthenticatedCopyWithImpl<$Res>
    implements $SessionStateAuthenticatedCopyWith<$Res> {
  _$SessionStateAuthenticatedCopyWithImpl(this._self, this._then);

  final SessionStateAuthenticated _self;
  final $Res Function(SessionStateAuthenticated) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(SessionStateAuthenticated(
null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as SessionData,
  ));
}

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionDataCopyWith<$Res> get session {
  
  return $SessionDataCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

/// @nodoc


class SessionStateUnauthenticated implements SessionState {
  const SessionStateUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStateUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState.unauthenticated()';
}


}




// dart format on
