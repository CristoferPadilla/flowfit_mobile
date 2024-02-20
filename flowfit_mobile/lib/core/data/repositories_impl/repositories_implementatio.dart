

import 'package:flowfit_mobile/core/data/data_source/remote/authentication_api.dart';
import 'package:flowfit_mobile/core/domain/repositories/authentication_repository.dart';
import 'package:flowfit_mobile/core/domain/responses/login_response.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository {
  final AuthenticationAPI _api;

  AuthenticationRepositoryImplementation(this._api);
  @override
  Future<String> get accessToken async{
    await Future.delayed(const Duration(seconds: 1));
    return "null";
  }

  @override
  Future<LoginResponse> login(String username, String password) {
    return _api.login(username, password);
  }

}