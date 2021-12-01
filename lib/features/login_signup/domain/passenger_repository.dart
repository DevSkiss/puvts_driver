import 'package:puvts_driver/features/login_signup/data/model/passenger_auth_response_model.dart';
import 'package:puvts_driver/features/login_signup/domain/driver_model.dart';

abstract class PassengerRepository {
  Future<PassengerAuthResponseModel> loginPassenger(
      {required String username, required String password});

  Future<DriverModel> signupPassenger({
    required String firstname,
    required String lastname,
    required String username,
    required String password,
  });
}
