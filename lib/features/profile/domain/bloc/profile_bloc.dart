import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/services/cached_services.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_model.dart';
import 'package:puvts_driver/features/profile/domain/bloc/profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    initialized();
  }

  final CachedService _cachedService = locator<CachedService>();

  void initialized() async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      PassengerModel passenger = await _cachedService.getUser();
      emit(state.copyWith(isLoading: false, user: passenger));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(hasError: true));
    }
  }
}
