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
      final assigned_membership = result.data['member']['assigned_membership'];
      final profilePicture = result.data['member']['profile_picture'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('accessToken', accessToken);
      await prefs.setString('id', id.toString());
      await prefs.setString('picture_profile', profilePicture);
      await prefs.setString('assigned_membership', assigned_membership.toString());

      print('AccessToken: $accessToken');
      print('ID del usuario: $id');
      print('Usuario es: $username');
      print('La foto es: $profilePicture');

      return LoginResponse.ok;
    } else if (result.statusCode == 401) {
      return LoginResponse.accesDenied;
    } else {
      // Otro tipo de error
      return LoginResponse.accesDenied;
    }
  } catch (error) {
    // Error de red
    return LoginResponse.networkError;
  }
}

}
