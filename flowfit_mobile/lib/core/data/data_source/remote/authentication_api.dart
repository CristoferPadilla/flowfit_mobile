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
