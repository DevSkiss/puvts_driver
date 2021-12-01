import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/errors_exception/exceptions.dart';
import 'package:puvts_driver/core/services/cached_services.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_auth_response_model.dart';
import 'package:puvts_driver/features/login_signup/domain/bloc/login_signup_state.dart';
import 'package:puvts_driver/features/login_signup/domain/driver_model.dart';
import 'package:puvts_driver/features/login_signup/domain/passenger_repository.dart';

class LoginSignupBloc extends Cubit<LoginSignupState> {
  LoginSignupBloc() : super(LoginSignupState()) {
    initial();
  }

  final PassengerRepository _userRepository = locator<PassengerRepository>();
  final CachedService _cachedService = locator<CachedService>();

  void initial() async {
    String? token = await _cachedService.getToken();
    if (token != '') {
      emit(state.copyWith(isCached: true));
    } else {
      emit(state.copyWith(isCached: false));
    }
  }

  void showHidePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void login({required String username, required String password}) async {
    emit(state.copyWith(isLoading: true));
    try {
      PassengerAuthResponseModel authResult = await _userRepository
          .loginPassenger(username: username, password: password);
      log(authResult.access);
      _cachedService.cacheToken(token: authResult.access);
      _cachedService.cacheUser(authResult.passenger!);
      emit(state.copyWith(
        isLoading: false,
        finished: true,
      ));
    } on PassengerNotFoundException {
      log('Wrong Password');
      emit(state.copyWith(isLoading: false, hasError: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
      log(e.toString());
    }

    emit(state.copyWith(hasError: false, finished: false));
  }

  void signup({
    required String firstname,
    required String lastname,
    required String username,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      DriverModel authResult = await _userRepository.signupPassenger(
          firstname: firstname,
          lastname: lastname,
          username: username,
          password: password);
      log(authResult.toString());
      emit(state.copyWith(
        isLoading: false,
        finished: true,
      ));
    } on PassengerNotFoundException {
      log('Something went wrong');
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
      ));
      emit(state.copyWith(hasError: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
      ));
      emit(state.copyWith(hasError: false));
    }
    emit(state.copyWith(
      finished: false,
    ));
  }
}
