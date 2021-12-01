import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_signup_state.freezed.dart';

@freezed
class LoginSignupState with _$LoginSignupState {
  factory LoginSignupState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(false) bool refresh,
    @Default(false) bool finished,
    @Default(true) bool obscurePassword,
    @Default(true) bool isCached,
  }) = _LoginSignupState;
}
