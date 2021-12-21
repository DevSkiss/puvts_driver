import 'package:firebase_auth/firebase_auth.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_model.dart';

abstract class PassengerRepository {
  Future<UserCredential> loginPassenger(
      {required String email, required String password});

  Future<UserCredential> signupPassenger({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });

  Future<PassengerModel> getDetails({required String userId});
}
