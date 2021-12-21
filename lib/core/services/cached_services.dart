import 'dart:convert';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/errors_exception/exceptions.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CachedService {
  Future<PassengerModel> getUser();

  Future<void> cacheUser(PassengerModel userToCache);

  Future<void> cacheToken({required String token});

  Future<String> getToken();

  Future<void> clearUser();
}

class CachedServiceImpl implements CachedService {
  final SharedPreferences prefs = locator<SharedPreferences>();

  @override
  Future<void> cacheToken({required String token}) {
    return prefs.setString('token', token);
  }

  @override
  Future<String> getToken() async {
    return prefs.getString('token') ?? '';
  }

  @override
  Future<PassengerModel> getUser() {
    final jsonString = prefs.getString('passenger');
    if (jsonString != null) {
      return Future.value(PassengerModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(PassengerModel userToCache) {
    return prefs.setString(
      'passenger',
      json.encode(userToCache.toJson()),
    );
  }

  @override
  Future<void> clearUser() {
    return prefs.clear();
  }
}
