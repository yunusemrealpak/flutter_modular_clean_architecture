// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthEventLogin value)?  login,TResult Function( AuthEventRegister value)?  register,TResult Function( AuthEventLogout value)?  logout,TResult Function( AuthEventCheckStatus value)?  checkStatus,TResult Function( AuthEventGetCurrentUser value)?  getCurrentUser,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthEventLogin() when login != null:
return login(_that);case AuthEventRegister() when register != null:
return register(_that);case AuthEventLogout() when logout != null:
return logout(_that);case AuthEventCheckStatus() when checkStatus != null:
return checkStatus(_that);case AuthEventGetCurrentUser() when getCurrentUser != null:
return getCurrentUser(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthEventLogin value)  login,required TResult Function( AuthEventRegister value)  register,required TResult Function( AuthEventLogout value)  logout,required TResult Function( AuthEventCheckStatus value)  checkStatus,required TResult Function( AuthEventGetCurrentUser value)  getCurrentUser,}){
final _that = this;
switch (_that) {
case AuthEventLogin():
return login(_that);case AuthEventRegister():
return register(_that);case AuthEventLogout():
return logout(_that);case AuthEventCheckStatus():
return checkStatus(_that);case AuthEventGetCurrentUser():
return getCurrentUser(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthEventLogin value)?  login,TResult? Function( AuthEventRegister value)?  register,TResult? Function( AuthEventLogout value)?  logout,TResult? Function( AuthEventCheckStatus value)?  checkStatus,TResult? Function( AuthEventGetCurrentUser value)?  getCurrentUser,}){
final _that = this;
switch (_that) {
case AuthEventLogin() when login != null:
return login(_that);case AuthEventRegister() when register != null:
return register(_that);case AuthEventLogout() when logout != null:
return logout(_that);case AuthEventCheckStatus() when checkStatus != null:
return checkStatus(_that);case AuthEventGetCurrentUser() when getCurrentUser != null:
return getCurrentUser(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String password)?  login,TResult Function( String email,  String password,  String name)?  register,TResult Function()?  logout,TResult Function()?  checkStatus,TResult Function()?  getCurrentUser,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthEventLogin() when login != null:
return login(_that.email,_that.password);case AuthEventRegister() when register != null:
return register(_that.email,_that.password,_that.name);case AuthEventLogout() when logout != null:
return logout();case AuthEventCheckStatus() when checkStatus != null:
return checkStatus();case AuthEventGetCurrentUser() when getCurrentUser != null:
return getCurrentUser();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String password)  login,required TResult Function( String email,  String password,  String name)  register,required TResult Function()  logout,required TResult Function()  checkStatus,required TResult Function()  getCurrentUser,}) {final _that = this;
switch (_that) {
case AuthEventLogin():
return login(_that.email,_that.password);case AuthEventRegister():
return register(_that.email,_that.password,_that.name);case AuthEventLogout():
return logout();case AuthEventCheckStatus():
return checkStatus();case AuthEventGetCurrentUser():
return getCurrentUser();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String password)?  login,TResult? Function( String email,  String password,  String name)?  register,TResult? Function()?  logout,TResult? Function()?  checkStatus,TResult? Function()?  getCurrentUser,}) {final _that = this;
switch (_that) {
case AuthEventLogin() when login != null:
return login(_that.email,_that.password);case AuthEventRegister() when register != null:
return register(_that.email,_that.password,_that.name);case AuthEventLogout() when logout != null:
return logout();case AuthEventCheckStatus() when checkStatus != null:
return checkStatus();case AuthEventGetCurrentUser() when getCurrentUser != null:
return getCurrentUser();case _:
  return null;

}
}

}

/// @nodoc


class AuthEventLogin implements AuthEvent {
  const AuthEventLogin({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthEventLoginCopyWith<AuthEventLogin> get copyWith => _$AuthEventLoginCopyWithImpl<AuthEventLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEventLogin&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.login(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthEventLoginCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthEventLoginCopyWith(AuthEventLogin value, $Res Function(AuthEventLogin) _then) = _$AuthEventLoginCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$AuthEventLoginCopyWithImpl<$Res>
    implements $AuthEventLoginCopyWith<$Res> {
  _$AuthEventLoginCopyWithImpl(this._self, this._then);

  final AuthEventLogin _self;
  final $Res Function(AuthEventLogin) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(AuthEventLogin(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthEventRegister implements AuthEvent {
  const AuthEventRegister({required this.email, required this.password, required this.name});
  

 final  String email;
 final  String password;
 final  String name;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthEventRegisterCopyWith<AuthEventRegister> get copyWith => _$AuthEventRegisterCopyWithImpl<AuthEventRegister>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEventRegister&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,name);

@override
String toString() {
  return 'AuthEvent.register(email: $email, password: $password, name: $name)';
}


}

/// @nodoc
abstract mixin class $AuthEventRegisterCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthEventRegisterCopyWith(AuthEventRegister value, $Res Function(AuthEventRegister) _then) = _$AuthEventRegisterCopyWithImpl;
@useResult
$Res call({
 String email, String password, String name
});




}
/// @nodoc
class _$AuthEventRegisterCopyWithImpl<$Res>
    implements $AuthEventRegisterCopyWith<$Res> {
  _$AuthEventRegisterCopyWithImpl(this._self, this._then);

  final AuthEventRegister _self;
  final $Res Function(AuthEventRegister) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? name = null,}) {
  return _then(AuthEventRegister(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthEventLogout implements AuthEvent {
  const AuthEventLogout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEventLogout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logout()';
}


}




/// @nodoc


class AuthEventCheckStatus implements AuthEvent {
  const AuthEventCheckStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEventCheckStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.checkStatus()';
}


}




/// @nodoc


class AuthEventGetCurrentUser implements AuthEvent {
  const AuthEventGetCurrentUser();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEventGetCurrentUser);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.getCurrentUser()';
}


}




/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthStateInitial value)?  initial,TResult Function( AuthStateLoading value)?  loading,TResult Function( AuthStateAuthenticated value)?  authenticated,TResult Function( AuthStateUnauthenticated value)?  unauthenticated,TResult Function( AuthStateUserLoaded value)?  userLoaded,TResult Function( AuthStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthStateInitial() when initial != null:
return initial(_that);case AuthStateLoading() when loading != null:
return loading(_that);case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that);case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthStateUserLoaded() when userLoaded != null:
return userLoaded(_that);case AuthStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthStateInitial value)  initial,required TResult Function( AuthStateLoading value)  loading,required TResult Function( AuthStateAuthenticated value)  authenticated,required TResult Function( AuthStateUnauthenticated value)  unauthenticated,required TResult Function( AuthStateUserLoaded value)  userLoaded,required TResult Function( AuthStateError value)  error,}){
final _that = this;
switch (_that) {
case AuthStateInitial():
return initial(_that);case AuthStateLoading():
return loading(_that);case AuthStateAuthenticated():
return authenticated(_that);case AuthStateUnauthenticated():
return unauthenticated(_that);case AuthStateUserLoaded():
return userLoaded(_that);case AuthStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthStateInitial value)?  initial,TResult? Function( AuthStateLoading value)?  loading,TResult? Function( AuthStateAuthenticated value)?  authenticated,TResult? Function( AuthStateUnauthenticated value)?  unauthenticated,TResult? Function( AuthStateUserLoaded value)?  userLoaded,TResult? Function( AuthStateError value)?  error,}){
final _that = this;
switch (_that) {
case AuthStateInitial() when initial != null:
return initial(_that);case AuthStateLoading() when loading != null:
return loading(_that);case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that);case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthStateUserLoaded() when userLoaded != null:
return userLoaded(_that);case AuthStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( AuthTokenEntity? token)?  authenticated,TResult Function()?  unauthenticated,TResult Function( UserEntity user)?  userLoaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthStateInitial() when initial != null:
return initial();case AuthStateLoading() when loading != null:
return loading();case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that.token);case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated();case AuthStateUserLoaded() when userLoaded != null:
return userLoaded(_that.user);case AuthStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( AuthTokenEntity? token)  authenticated,required TResult Function()  unauthenticated,required TResult Function( UserEntity user)  userLoaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case AuthStateInitial():
return initial();case AuthStateLoading():
return loading();case AuthStateAuthenticated():
return authenticated(_that.token);case AuthStateUnauthenticated():
return unauthenticated();case AuthStateUserLoaded():
return userLoaded(_that.user);case AuthStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( AuthTokenEntity? token)?  authenticated,TResult? Function()?  unauthenticated,TResult? Function( UserEntity user)?  userLoaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case AuthStateInitial() when initial != null:
return initial();case AuthStateLoading() when loading != null:
return loading();case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that.token);case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated();case AuthStateUserLoaded() when userLoaded != null:
return userLoaded(_that.user);case AuthStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AuthStateInitial implements AuthState {
  const AuthStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class AuthStateLoading implements AuthState {
  const AuthStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class AuthStateAuthenticated implements AuthState {
  const AuthStateAuthenticated(this.token);
  

 final  AuthTokenEntity? token;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateAuthenticatedCopyWith<AuthStateAuthenticated> get copyWith => _$AuthStateAuthenticatedCopyWithImpl<AuthStateAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateAuthenticated&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'AuthState.authenticated(token: $token)';
}


}

/// @nodoc
abstract mixin class $AuthStateAuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthStateAuthenticatedCopyWith(AuthStateAuthenticated value, $Res Function(AuthStateAuthenticated) _then) = _$AuthStateAuthenticatedCopyWithImpl;
@useResult
$Res call({
 AuthTokenEntity? token
});




}
/// @nodoc
class _$AuthStateAuthenticatedCopyWithImpl<$Res>
    implements $AuthStateAuthenticatedCopyWith<$Res> {
  _$AuthStateAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthStateAuthenticated _self;
  final $Res Function(AuthStateAuthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = freezed,}) {
  return _then(AuthStateAuthenticated(
freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as AuthTokenEntity?,
  ));
}


}

/// @nodoc


class AuthStateUnauthenticated implements AuthState {
  const AuthStateUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class AuthStateUserLoaded implements AuthState {
  const AuthStateUserLoaded(this.user);
  

 final  UserEntity user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateUserLoadedCopyWith<AuthStateUserLoaded> get copyWith => _$AuthStateUserLoadedCopyWithImpl<AuthStateUserLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateUserLoaded&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.userLoaded(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthStateUserLoadedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthStateUserLoadedCopyWith(AuthStateUserLoaded value, $Res Function(AuthStateUserLoaded) _then) = _$AuthStateUserLoadedCopyWithImpl;
@useResult
$Res call({
 UserEntity user
});




}
/// @nodoc
class _$AuthStateUserLoadedCopyWithImpl<$Res>
    implements $AuthStateUserLoadedCopyWith<$Res> {
  _$AuthStateUserLoadedCopyWithImpl(this._self, this._then);

  final AuthStateUserLoaded _self;
  final $Res Function(AuthStateUserLoaded) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(AuthStateUserLoaded(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,
  ));
}


}

/// @nodoc


class AuthStateError implements AuthState {
  const AuthStateError(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateErrorCopyWith<AuthStateError> get copyWith => _$AuthStateErrorCopyWithImpl<AuthStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthStateErrorCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthStateErrorCopyWith(AuthStateError value, $Res Function(AuthStateError) _then) = _$AuthStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AuthStateErrorCopyWithImpl<$Res>
    implements $AuthStateErrorCopyWith<$Res> {
  _$AuthStateErrorCopyWithImpl(this._self, this._then);

  final AuthStateError _self;
  final $Res Function(AuthStateError) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AuthStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
