

import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:blogspot/features/auth/domain/repositories/passwordRepository/password_repository.dart';
import 'package:dio/dio.dart';

class PasswordRepositoryImpl implements PasswordRepository{
  final UserApiService _userApiService;

  PasswordRepositoryImpl(this._userApiService);

  //forgot password method
  @override
  Future<DataState<bool>> forgotPassword(String email, String password) async{
    try {
      final httpresponse =
          await _userApiService.forgotPassword(email, password);

      if (httpresponse.response.statusCode == 201) {
        return DataSuccess(true);
      } else {
        return DataFailed("some thing went wrong, try again");
      }
    } on DioException catch (e) {
      return DataFailed('something went wrong, try again : $e');
    }
  }
}