// ignore_for_file: avoid_print

import 'package:flowfit_mobile/core/data/helpers/http.dart';
import 'package:flowfit_mobile/core/data/helpers/http_method.dart';
import 'package:flowfit_mobile/core/domain/responses/login_response.dart';

class AuthenticationAPI {
  final Http _http;

  AuthenticationAPI(this._http);

  Future<LoginResponse> login(String username, String password) async {
    try {
      final result = await _http.request(
        '/members/login',
        body: {'username': username, 'password': password},
        method: HttpMethod.post,
        timeOut: const Duration(seconds: 10),
      );

      print("result data ${result.data}");
      print("result data runtimeTupe ${result.data.runtimeType}");
      print("result error data ${result.error?.data}");
      print("result error ${result.statusCode}");

      if (result.statusCode == 200) {
        return LoginResponse.ok;
      } else {
        return LoginResponse.networkError;
      }
    } catch (error) {
      return LoginResponse.networkError;
    }
  }
}
