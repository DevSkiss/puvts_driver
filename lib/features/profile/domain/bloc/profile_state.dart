import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_model.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(false) bool isFinished,
    PassengerModel? user,
  }) = _ProfileState;
}
