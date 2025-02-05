import 'package:blogspot/core/resources/data_state.dart';

abstract class PasswordRepository {
  //forgot password
  Future<DataState<bool>> forgotPassword(String email,String password);
}
