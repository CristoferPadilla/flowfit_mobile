import 'package:flowfit_mobile/core/domain/responses/login_response.dart';

abstract class AuthenticationRepository{
  Future<String?> get accessToken;
  Future<LoginResponse> login(String username, String password);    
  // Future<void> setAccessToken(String? token);
}