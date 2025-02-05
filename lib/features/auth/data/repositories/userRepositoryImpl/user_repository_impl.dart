import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:blogspot/features/auth/domain/entities/user_entity.dart';
import 'package:blogspot/features/auth/domain/repositories/userRepository/user_repository.dart';
import 'package:blogspot/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _userApiService;

  UserRepositoryImpl(this._userApiService);

  @override
  Future<DataState<UserModel>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  //login method
  @override
  Future<DataState<UserModel>> login(String email, String password) async {
    try {
      final httpresponse = await _userApiService.login(
        {'email': email, 'password': password},
      );

      //check if the response is successful
      if (httpresponse.response.statusCode == 200) {
        return DataSuccess(httpresponse.data);
      } else {
        return DataFailed(
          'An error occured while trying to login, please try again',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data['message'] ??
          'An error occured while trying to login, please try again';

      if (error == 'User-does-not-exist') {
        return DataFailed(
          'User does not exist, please create an account to continue',
        );
      } else if (error == 'Invalid-email-or-password') {
        return DataFailed(
          'Invalid email or password, please try again',
        );
      } else {
        return DataFailed(
          e.response?.data['message'] ??
              'An error occured while trying to login, please try again',
        );
      }
    }
  }


  //logout mrthod
  @override
  Future<DataState> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.remove('token');

    if (pref.getString('token') == null) {
      return DataSuccess('User logged out successfully');
    } else {
      return DataFailed('An error occured while trying to logout');
    }
  }

  //signup method
  @override
  Future<DataState<UserModel>> register(
      String fullName, String email, String password) async {
    try {
      final httpresponse = await _userApiService.register(
        {'fullName': fullName, 'email': email, 'password': password},
      );

      //check for response
      if (httpresponse.response.statusCode == 201) {
        return DataSuccess(httpresponse.data);
      } else {
        return DataFailed(
          'An error occured while trying to login, please try again',
        );
      }
    } on DioException catch (e) {
      final error = e.response?.data['message'] ??
          'An error occured while trying to login, please try again';

      //if user already have an account
      if (error == "User-already-exists") {
        return DataFailed(
          "You already have an account, please login or forgot password",
        );
      } else {
        return DataFailed(
          e.response?.data['message'] ??
              'An error occured while trying to login, please try again',
        );
      }
    }
  }

  @override
  Future<DataState<UserModel>> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  


 
}
