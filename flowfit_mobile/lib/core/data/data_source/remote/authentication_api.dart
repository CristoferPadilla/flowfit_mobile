// ignore_for_file: avoid_print

import 'package:flowfit_mobile/core/data/helpers/http.dart';
import 'package:flowfit_mobile/core/data/helpers/http_method.dart';
import 'package:flowfit_mobile/core/domain/responses/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      if (result.statusCode == 200) {
        final accessToken = result.data['accessToken'];
        final id = result.data['member']['id'];

        // final id = result.data['id'];
        if (accessToken != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', username);
          await prefs.setString('accessToken', accessToken);
          await prefs.setString('id', id.toString());
          print('AccessToken: $accessToken');
          print('ID del usuario: $id');
        } else {
          print('Error: AccessToken no encontrado en la respuesta.');
        }
        print(result.data);

        return LoginResponse.ok;
      } else {
        return LoginResponse.networkError;
      }
    } catch (error) {
      return LoginResponse.networkError;
    }
  }
}
