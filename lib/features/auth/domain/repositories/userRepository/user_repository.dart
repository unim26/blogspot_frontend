import 'package:blogspot/features/auth/domain/entities/user_entity.dart';

import '../../../../../core/resources/data_state.dart';

abstract class UserRepository {
  //for login user
  Future<DataState<UserEntity>> login(String email, String password);

  //for register user
  Future<DataState<UserEntity>> register(
      String fullName, String email, String password);

  //for get user
  Future<DataState<UserEntity>> getUser();

  //for update user
  Future<DataState<UserEntity>> updateUser(UserEntity user);

  //for logout user
  Future<DataState> logout();
}
