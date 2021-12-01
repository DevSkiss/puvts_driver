// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'login_signup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginSignupStateTearOff {
  const _$LoginSignupStateTearOff();

  _LoginSignupState call(
      {bool isLoading = false,
      bool hasError = false,
      bool refresh = false,
      bool finished = false,
      bool obscurePassword = true,
      bool isCached = true}) {
    return _LoginSignupState(
      isLoading: isLoading,
      hasError: hasError,
      refresh: refresh,
      finished: finished,
      obscurePassword: obscurePassword,
      isCached: isCached,
    );
  }
}

/// @nodoc
const $LoginSignupState = _$LoginSignupStateTearOff();

/// @nodoc
mixin _$LoginSignupState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  bool get refresh => throw _privateConstructorUsedError;
  bool get finished => throw _privateConstructorUsedError;
  bool get obscurePassword => throw _privateConstructorUsedError;
  bool get isCached => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginSignupStateCopyWith<LoginSignupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginSignupStateCopyWith<$Res> {
  factory $LoginSignupStateCopyWith(
          LoginSignupState value, $Res Function(LoginSignupState) then) =
      _$LoginSignupStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      bool hasError,
      bool refresh,
      bool finished,
      bool obscurePassword,
      bool isCached});
}

/// @nodoc
class _$LoginSignupStateCopyWithImpl<$Res>
    implements $LoginSignupStateCopyWith<$Res> {
  _$LoginSignupStateCopyWithImpl(this._value, this._then);

  final LoginSignupState _value;
  // ignore: unused_field
  final $Res Function(LoginSignupState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? hasError = freezed,
    Object? refresh = freezed,
    Object? finished = freezed,
    Object? obscurePassword = freezed,
    Object? isCached = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      refresh: refresh == freezed
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool,
      finished: finished == freezed
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      obscurePassword: obscurePassword == freezed
          ? _value.obscurePassword
          : obscurePassword // ignore: cast_nullable_to_non_nullable
              as bool,
      isCached: isCached == freezed
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$LoginSignupStateCopyWith<$Res>
    implements $LoginSignupStateCopyWith<$Res> {
  factory _$LoginSignupStateCopyWith(
          _LoginSignupState value, $Res Function(_LoginSignupState) then) =
      __$LoginSignupStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      bool hasError,
      bool refresh,
      bool finished,
      bool obscurePassword,
      bool isCached});
}

/// @nodoc
class __$LoginSignupStateCopyWithImpl<$Res>
    extends _$LoginSignupStateCopyWithImpl<$Res>
    implements _$LoginSignupStateCopyWith<$Res> {
  __$LoginSignupStateCopyWithImpl(
      _LoginSignupState _value, $Res Function(_LoginSignupState) _then)
      : super(_value, (v) => _then(v as _LoginSignupState));

  @override
  _LoginSignupState get _value => super._value as _LoginSignupState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? hasError = freezed,
    Object? refresh = freezed,
    Object? finished = freezed,
    Object? obscurePassword = freezed,
    Object? isCached = freezed,
  }) {
    return _then(_LoginSignupState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      refresh: refresh == freezed
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as bool,
      finished: finished == freezed
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      obscurePassword: obscurePassword == freezed
          ? _value.obscurePassword
          : obscurePassword // ignore: cast_nullable_to_non_nullable
              as bool,
      isCached: isCached == freezed
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LoginSignupState implements _LoginSignupState {
  _$_LoginSignupState(
      {this.isLoading = false,
      this.hasError = false,
      this.refresh = false,
      this.finished = false,
      this.obscurePassword = true,
      this.isCached = true});

  @JsonKey(defaultValue: false)
  @override
  final bool isLoading;
  @JsonKey(defaultValue: false)
  @override
  final bool hasError;
  @JsonKey(defaultValue: false)
  @override
  final bool refresh;
  @JsonKey(defaultValue: false)
  @override
  final bool finished;
  @JsonKey(defaultValue: true)
  @override
  final bool obscurePassword;
  @JsonKey(defaultValue: true)
  @override
  final bool isCached;

  @override
  String toString() {
    return 'LoginSignupState(isLoading: $isLoading, hasError: $hasError, refresh: $refresh, finished: $finished, obscurePassword: $obscurePassword, isCached: $isCached)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoginSignupState &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.hasError, hasError) ||
                const DeepCollectionEquality()
                    .equals(other.hasError, hasError)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality()
                    .equals(other.refresh, refresh)) &&
            (identical(other.finished, finished) ||
                const DeepCollectionEquality()
                    .equals(other.finished, finished)) &&
            (identical(other.obscurePassword, obscurePassword) ||
                const DeepCollectionEquality()
                    .equals(other.obscurePassword, obscurePassword)) &&
            (identical(other.isCached, isCached) ||
                const DeepCollectionEquality()
                    .equals(other.isCached, isCached)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(hasError) ^
      const DeepCollectionEquality().hash(refresh) ^
      const DeepCollectionEquality().hash(finished) ^
      const DeepCollectionEquality().hash(obscurePassword) ^
      const DeepCollectionEquality().hash(isCached);

  @JsonKey(ignore: true)
  @override
  _$LoginSignupStateCopyWith<_LoginSignupState> get copyWith =>
      __$LoginSignupStateCopyWithImpl<_LoginSignupState>(this, _$identity);
}

abstract class _LoginSignupState implements LoginSignupState {
  factory _LoginSignupState(
      {bool isLoading,
      bool hasError,
      bool refresh,
      bool finished,
      bool obscurePassword,
      bool isCached}) = _$_LoginSignupState;

  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  bool get hasError => throw _privateConstructorUsedError;
  @override
  bool get refresh => throw _privateConstructorUsedError;
  @override
  bool get finished => throw _privateConstructorUsedError;
  @override
  bool get obscurePassword => throw _privateConstructorUsedError;
  @override
  bool get isCached => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoginSignupStateCopyWith<_LoginSignupState> get copyWith =>
      throw _privateConstructorUsedError;
}
