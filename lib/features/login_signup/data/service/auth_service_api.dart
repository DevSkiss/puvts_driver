import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/errors_exception/exceptions.dart';
import 'package:puvts_driver/core/services/cached_services.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_model.dart';

abstract class AuthApiService {
  Future<UserCredential> login(
      {required String email, required String password});

  Future<UserCredential> signup(
      {required String firstname,
      required String lastname,
      required String email,
      required String password});
  Future<void> logout();

  Future<bool> isLoggedIn();

  Future<PassengerModel> getDetails({required String id});
}

class AuthApiServiceImpl extends AuthApiService {
  //var client = http.Client();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Logger _logger = Logger();
  final CachedService _cachedService = locator<CachedService>();

  @override
  Future<void> logout() async {
    try {
      CollectionReference location =
          FirebaseFirestore.instance.collection('location');
      PassengerModel _user = await _cachedService.getUser();

      _logger.i('Id is: ${_user.id}');

      var result = await firestore
          .collection('location')
          .where('user_id', isEqualTo: _user.id)
          .where('user_type', isEqualTo: 'driver')
          .get();

      location
          .doc(result.docs[0].id)
          .update({'active': false})
          .then((value) => _logger.i("Location Updated"))
          .catchError((error) => _logger.i("Failed to update user: $error"));
      await auth.signOut();
      await _cachedService.clearUser();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      _logger.i('Loggin In');
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      CollectionReference location =
          FirebaseFirestore.instance.collection('location');

      var result = await firestore
          .collection('location')
          .where('user_id', isEqualTo: userCredential.user?.uid)
          .where('user_type', isEqualTo: 'driver')
          .get();

      location
          .doc(result.docs[0].id)
          .update({'active': true})
          .then((value) => _logger.i("Location Updated"))
          .catchError((error) => _logger.i("Failed to update user: $error"));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      _logger.e(e);
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        throw FirebaseAuthException(code: '404');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        throw FirebaseAuthException(code: '401');
      }
    } catch (e) {
      _logger.e(e);
      throw ServerException();
    }
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signup(
      {required String firstname,
      required String lastname,
      required String email,
      required String password}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return users
          .add({
            'user_id': userCredential.user?.uid,
            'firstname': firstname,
            'lastname': lastname,
            'email': email,
          })
          .then((value) => userCredential)
          .catchError((error) => throw UserAlreadyExisting());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        throw FirebaseAuthException(code: 'weak-password');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        throw FirebaseAuthException(code: 'email-already-in-use');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw UnimplementedError();
    }
    throw UnimplementedError();
  }

  @override
  Future<PassengerModel> getDetails({required String id}) async {
    try {
      var result = await firestore
          .collection('users')
          .where('user_id', isEqualTo: id)
          .get();
      return PassengerModel.fromJson(result.docs[0].data());
    } on FirebaseAuthException {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    bool? result;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        result = false;
      } else {
        result = true;
      }
    });
    return result ?? false;
  }
}
