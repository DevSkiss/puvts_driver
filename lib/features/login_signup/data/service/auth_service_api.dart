import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:puvts_driver/core/constants/http.dart';
import 'package:puvts_driver/core/errors_exception/exceptions.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_auth_response_model.dart';
import 'package:puvts_driver/features/login_signup/domain/driver_model.dart';

abstract class AuthApiService {
  Future<PassengerAuthResponseModel> login(
      {required String username, required String password});

  Future<DriverModel> signup(
      {required String firstname,
      required String lastname,
      required String username,
      required String password});
}

class AuthApiServiceImpl extends AuthApiService {
  var client = http.Client();

  @override
  Future<PassengerAuthResponseModel> login(
      {required String username, required String password}) async {
    final requestBody = jsonEncode(<String, String>{
      'username': username,
      'password': password,
    });
    dynamic result = await _postUserToUrl(
        Uri.parse(BASE_URL + '/api/driver/login'),
        body: requestBody);
    return PassengerAuthResponseModel.fromJson(json.decode(result));
  }

  @override
  Future<DriverModel> signup(
      {required String firstname,
      required String lastname,
      required String username,
      required String password}) async {
    final requestBody = jsonEncode(<String, String>{
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'password': password,
    });
    dynamic result = await _postUserToUrl(Uri.parse(BASE_URL + '/api/driver'),
        body: requestBody);
    return DriverModel.fromJson(json.decode(result));
  }

  Future<dynamic> _postUserToUrl(Uri url, {Object? body}) async {
    final response = await client.post(
      url,
      headers: {
        HTTP_CONTENT_TYPE: HTTP_APPLICATION_JSON,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw PassengerNotFoundException();
    } else {
      throw ServerException();
    }
  }
}
