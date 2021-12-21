import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/errors_exception/exceptions.dart';
import 'package:puvts_driver/core/services/cached_services.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_model.dart';
import 'package:puvts_driver/features/login_signup/data/service/auth_service_api.dart';
import 'package:puvts_driver/features/login_signup/domain/bloc/login_signup_state.dart';
import 'package:puvts_driver/features/login_signup/domain/passenger_repository.dart';

class LoginSignupBloc extends Cubit<LoginSignupState> {
  LoginSignupBloc()
      : super(LoginSignupState(
          hasError: false,
          finished: false,
          isCached: false,
          isLoading: false,
        )) {
    initial();
  }

  final PassengerRepository _userRepository = locator<PassengerRepository>();
  final CachedService _cachedService = locator<CachedService>();
  final AuthApiService _authApiService = locator<AuthApiService>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Logger _logger = Logger();

  void initial() async {
    _logger.i('Initialized');
    try {
      emit(state.copyWith(isLoading: true));
      await _authApiService.logout();

      emit(state.copyWith(
        isLoading: false,
        hasError: false,
        isCached: false,
        finished: false,
      ));
      // PassengerModel? user = await _cachedService.getUser();

      // if (user.id != '') {
      //   emit(state.copyWith(
      //     isCached: true,
      //     finished: true,
      //     isLoading: false,
      //     hasError: false,
      //   ));
      // } else {

      //   emit(state.copyWith(isCached: false, isLoading: false));
      // }
    } on CacheException {
      _logger.w('No User Cached');
      emit(state.copyWith(
        isLoading: false,
      ));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        finished: false,
      ));
    }
  }

  void showHidePassword() {
    _logger.i('showhide gets run');
    emit(state.copyWith(
      obscurePassword: !state.obscurePassword,
    ));
  }

  void login({required String email, required String password}) async {
    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      finished: false,
    ));
    try {
      UserCredential authResult = await _userRepository.loginPassenger(
          email: email, password: password);

      PassengerModel userDetails =
          await _userRepository.getDetails(userId: authResult.user?.uid ?? '');

      if (authResult.user.toString() != '') {
        _cachedService.cacheUser(userDetails);
      }
      //   _cachedService.cacheUser(authResult.passenger!);
      CollectionReference location =
          FirebaseFirestore.instance.collection('location');

      var result = await firestore
          .collection('location')
          .where('user_id', isEqualTo: userDetails.id)
          .where('user_type', isEqualTo: 'driver')
          .get();

      location
          .doc(result.docs[0].id)
          .update({'active': true})
          .then((value) => print("Driver Active"))
          .catchError((error) => print("Failed to update location: $error"));
      emit(state.copyWith(
        isLoading: false,
        finished: true,
      ));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(isLoading: false, hasError: true));
    }

    emit(state.copyWith(hasError: false, finished: false));
  }
}
